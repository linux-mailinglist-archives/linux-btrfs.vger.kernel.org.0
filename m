Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A95C7AF6AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 01:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjIZXUE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 19:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjIZXSB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 19:18:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FC41A67B
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695766759; x=1696371559; i=quwenruo.btrfs@gmx.com;
 bh=rmBFkgDiL0QQxv0Zwta5J8YlxdXUM9fb3qbC0Oh0oyA=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=gColCNIOauQ2BLDllBlMoEgIwNG5E4M01XlYTEBJBUgCH1Xs5tHEHMfSeqbiYj0CdLh8tOFaKab
 IFEPgJsEGteJNvLaplNco9NvTTw5vbZOwuDSC5SaUVXk8RYKSPS79usOL74bqtELRfRIqYtZJxeuR
 lPbAwrYFsKqmrsG4ZnTRNcbVpujyyNY+rSv9/MxODynhcoyBkha/ycbE1jIdBifPS2PLEK4d+jR8y
 0CTYUlnEPNWEgo5nrJdT0t461sbhFZHwbJxzASf55t8YGg4jwDPxfHubj07Yioa0Xd+ViO1jRmnAt
 4zBpzefOV8I9zARfKKoN0Y1mORzsBDtsKlew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3DM-1qrtBE06fo-00FTmT; Tue, 26
 Sep 2023 23:12:20 +0200
Message-ID: <ec16080c-4ce7-4fe1-9a7e-376313345f47@gmx.com>
Date:   Wed, 27 Sep 2023 06:42:16 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: always print transaction aborted messages with an
 error level
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <70f9a616df5b0f4268f309312d93d3a972fd9289.1695753057.git.fdmanana@suse.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <70f9a616df5b0f4268f309312d93d3a972fd9289.1695753057.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IuNVt3SWEPmHzY/GCHTJtRspulUFXEw5u+XTQhOLSOQ07+uaDql
 Sn5HF34v5IhygcDmmgIEM0IujER0ilyCaVtGTjD8j8+JS117VUavkUJm+0AbFf7dDNn24Ue
 UmCDeh5Y2j1XBYKIpLNF/Y3DtwW8/8q1Z30uuxXehrkzq9Gw31T6C3FwzWzdBoKmPrXclRT
 UQom51ieBmpBL834r6+ZA==
UI-OutboundReport: notjunk:1;M01:P0:Rq2ccptOPRc=;yhlN1OG1JyTssIheuDUaCjfwECx
 OgwmbOfum+TETAQEbGUJb+IDFjYhGwKalusz9zq1CSdrNNv/DbxZFJmgc5vujpPL1nl+VS9cw
 oqOohg/NYfe7obZgqUkS0Cvcczq/pG1y2wkcUdVGEz2fCiOsNapyWN7WeyvuaTxKJkqClpU5Q
 7PSnGc00pDYoUuCYCFLjrZ1eqvcYzaQeLMu++unQrsQ4J50CY+g2xzDSCdgq+1RbHBAP8Za6z
 f3YDUDBbRmPAG/IyQgAhQnqiDnbUND4SK15mpF35aoBNK0MW0hV4ykErH6r6VpW/DI39fyXFD
 I+r0HzdJod4MxPHxKFtY/9fZ6NJO+U9AlYJ7R2kyfSJtgVHHbRitKplIdVDReumJZEiuwTkui
 Hji5f/3auZ/JDoVHSa+ft31GqhD2athkhHISZMpkUffzY0BV7VSlWEWysY9hFHR613AeKXDX5
 QJIoc/P/JCppuTCZQ1HnoKk2P4oT++fXVYR8VOr3Vrbd/cYcO4IT2UWIs+FuDSjBe7yzmmply
 nNf9ajjXc9tYFF1fvzLvkAg+jF0/C9v1GVtue2piURVamvX/SFXDtkEgiBOh41ezU5SEJ7YGe
 xJOhd1SuPRgpfDzW73Fecg1HOTBbLNBsVuYxsnGsltrXvY2ueECOweVQiZ+Q7t5KX3csz/wVH
 ltLykKLr3n1uWTmAZmf69K+Km2705LdLovX0pCOjltkKqlPQESy4KWRQLJJOnrVAP2zUnwxj4
 LZ0uKAIDTc37367w6ZakBbtmZgFjK2V9BXHvI8v0cV1E4Quk6itskXAP5/MwZ53TwFDYRC+up
 pwj+Ybxx1Hcryt/12YOR6UXlxFIxomOIijpi8EmHzsoZokKheF7Mld+kiJ0faWw4NPDZuVT6l
 7v2NiBps6kAyD2Cc3emARXbXAAENWboweZ7ROUAXJw36tK0G/knHw0QKiWniUPo5KtdiwT/Pj
 gyqQK3lxTmJW+taI1BVY47plCoQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/27 04:01, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> Commit b7af0635c87f ("btrfs: print transaction aborted messages with an
> error level") changed the log level of transaction aborted messages from
> a debug level to an error level, so that such messages are always visibl=
e
> even on production systems where the log level is normally above the deb=
ug
> level (and also on some syzbot reports).
>
> Later, commit fccf0c842ed4 ("btrfs: move btrfs_abort_transaction to
> transaction.c") changed the log level back to debug level when the error
> number for a transaction abort should not have a stack trace printed.
> This happened for absolutely no reason. It's always useful to print
> transaction abort messages with an error level, regardless of whether
> the error number should cause a stack trace or not.
>
> So change back the log level to error level.
>
> Fixes: fccf0c842ed4 ("btrfs: move btrfs_abort_transaction to transaction=
.c")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/transaction.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index de58776de307..f5bf3489d8c5 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -222,8 +222,8 @@ do {								\
>   			(error))) {					\
>   			/* Stack trace printed. */			\
>   		} else {						\
> -			btrfs_debug((trans)->fs_info,			\
> -				    "Transaction aborted (error %d)", \
> +			btrfs_err((trans)->fs_info,			\
> +				  "Transaction aborted (error %d)",     \
>   				  (error));			\
>   		}						\
>   	}							\
