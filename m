Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF09786735
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 07:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbjHXFlR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 01:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbjHXFlF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 01:41:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85A9E66
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 22:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692855659; x=1693460459; i=quwenruo.btrfs@gmx.com;
 bh=abG3856gcvJeNaCXqeOgYNC5yPhTr7tjjz0ZvLq6GBI=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=L+d1xXA/e5F40yjtESebf8aiqp7WLrxAIoplq6d1a1ZkuBNlyvAxIGsgW3Ewha6VQCAwymD
 T/2jP1BklksQirgINKobjwMTKATtmPRvxnnpNUMUPh14t2ChYkIGRAHFQ8s41FvaWnqhImRO0
 gFXjAts3HylTyfKk1VNUnQjK/NVop6znjwvsjAUOEBtTKJhcUTcn6dW2elFieEC1w//xjJeUd
 osudzSTU5md5T32oRpDcTnGEQo5DDBx72nU9u6RZH/20TcwXnIMNcelAn0tTK4E8usdYqtxui
 SpVvIM6R7hCVbd/McSy0mWXVKVSi43wkC0fRn9hMigxAcOKom/tg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNswE-1qNzO62VSa-00OD2k; Thu, 24
 Aug 2023 07:40:59 +0200
Message-ID: <04b21f25-a80e-4e1b-a70a-3401ca3c2af2@gmx.com>
Date:   Thu, 24 Aug 2023 13:40:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs check: root errors 400, nbytes wrong
Content-Language: en-US
To:     Cebtenzzre <cebtenzzre@gmail.com>, linux-btrfs@vger.kernel.org
References: <4a18c53b36e312b3de3296145984ed74323494ff.camel@gmail.com>
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
In-Reply-To: <4a18c53b36e312b3de3296145984ed74323494ff.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TdRDnZUzXr2nD8KlrWU+5anSUO7w6zlELkitTUiw+B1154xu3LA
 fohB19jeyOqbx3W8pcrpauxYu7HvFz+WspvotOo/F+4hjmjOTH70MIq2y39+5GLOwWMO7OX
 aGshUK3DUCbFtpXQx2Sx6izJt8vUEJj34MuWudAh1egK1sYQ6rWBFHjNQAN4HtIDoUKgtWJ
 kxrj2tFonKqwMoO0BayoQ==
UI-OutboundReport: notjunk:1;M01:P0:4MnfKyANkG4=;nlsDKdebQ4PwdlPoaH51fajL/qh
 p2xiTX73D5hiSixUXnpPAB7tulJVugaWbiZn1qk3HQZvPhAb7/bx9G/08c3Q+F3b77DqjAb7O
 yK7A7UDfdgb9YHVvwKje0gQbxopRKcoXwYK+Xryc8FG4XswoFNctYtF8HVsnFWsABhfLEvlJp
 GsT8DJvVd8u55XI2oAhW4m8PkjGJZV3A6/3gGPRKI1C8/Q1084ieyd35NAQqLNcgtwVXq1Oz6
 +LzgQdbc1NQR0YI9xSEAFGZA1uNuUwcnUcF8Vo6B0zFlXv0D1MgIef3mRpPKHj3JfyMsyLL0t
 VhWg6xji+/YWTwEOMn6YG4EiMGM56a19SK4lAL7rZr3PYwxIX2EN1BNWsbzjK6SWNik4t+Tre
 xwmDN8EpWEGHuDgy4Kr1JSFLjk1vtmUscZXYwkzbkCP+iQs9pT7DIqo2mXtsrKJDkIWl/gZrA
 GXPhL6KE8sRQbMbnIgSo1UELw6kbp0XJ4N8F+DHFlFij0sbbHCyMffGJg3I12mok/IPqQaX+R
 wXHtsvPeugZ3+rvg7Qhh8whVrLJK908k7QliMKLlHGA6eW++8+e3N557+7hbpv8M0GPxUKnn+
 qmTRxpyzzchjnREub/+xD66O9c8n9z5gjenR+vFcNFjWloVRVgzfooWWhq+pejGGzwmzWV/Y1
 +Tb5nUMYYrK3lofNgRM4auEXxS3BI92kcs5SAjWT3GNZqB1qXLcJ2/Toqy+W53vYxybNPP45v
 Z4JNnKevXCScTovOIJu1IsiBO97i+nXTxVnILtF7q8h33b21m95EPPEb7P3AnvyJBFqSECjdY
 EEkEV60JuBqho/RHf7NfjfWjVSHeSOvX+IrxDTrWfJXcXrkQZCJ1QhxXX+wNBoqXdxYhlrNsu
 kegOb0c7MqDLTbk8Vkbf0jlcuTVEVOFQ020xTJAOINJ0Ut2bbU8mFFh1JLUZvtLPQG9pNhC1T
 SYJGjb6FAfWZimU0zmVT3c1dpi8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/24 08:38, Cebtenzzre wrote:
> I am getting these errors from btrfs-progs v6.3.3 on Linux 6.4.7.
>
> Can I safely run `btrfs check --repair`?
>
> root 258 inode 123827824 errors 400, nbytes wrong

Just to be extra safe, you may want to run "btrfs check --mode=3Dlowmem"
to get a more human readable output.

But it's mostly fine, a btrfs check --repair should be safe if and only
if those are the only errors.

Thanks,
Qu
> root 15685 inode 123827824 errors 400, nbytes wrong
> root 15752 inode 123827824 errors 400, nbytes wrong
> root 15760 inode 123827824 errors 400, nbytes wrong
> root 15768 inode 123827824 errors 400, nbytes wrong
> root 15772 inode 123827824 errors 400, nbytes wrong
> root 15786 inode 123827824 errors 400, nbytes wrong
> root 15798 inode 123827824 errors 400, nbytes wrong
> root 15814 inode 123827824 errors 400, nbytes wrong
> root 15818 inode 123827824 errors 400, nbytes wrong
> ERROR: errors found in fs roots
>
> Thanks,
> Cebtenzzre
