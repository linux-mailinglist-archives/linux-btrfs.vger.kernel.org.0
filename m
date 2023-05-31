Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1765D717235
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 02:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjEaACH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 20:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjEaACE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 20:02:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DFA135
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 17:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685491312; i=quwenruo.btrfs@gmx.com;
        bh=nuzoK+/Gwd/5H7BKviUlVlLct0TzEvsMJguDBQwwN9g=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=j1fV3MHIlzdlgnUuC6JD3i4bpX3oN0EXhaBcfmt72YeOhryr5vim6LT2D8oh3QSt4
         94l9mCxHe8blbmKJMCCZ5aBb3lVnEoqkhhiCWGekeARRrbV3FWsco1C1gBJuTTEVDz
         lxagvzyWAGAu5qwX0JI8GI2sy254mE4DTu8LyViORj7fIKfryFYmNgVpAO3lja+/1t
         YMZVU0p1KTNlRo4OdT51jsUke871KqytQpDkW3IGTDSokMALF0F4YmVQH29kZBxA/N
         K0QUBv0sooYsvM/B/T8Wn/nXlb21eZNMHGyTy3CRuXyUKQ2LiE4oUInOeJXMvLHmKW
         4S3FuQW5BgSBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWigq-1pbf6N2mFc-00X5hz; Wed, 31
 May 2023 02:01:52 +0200
Message-ID: <9ffdb317-e679-0fb9-4181-c40526d7668d@gmx.com>
Date:   Wed, 31 May 2023 08:01:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] btrfs-progs: add CHANGING_FSID_V2 to print-tree
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <8e152cd504552e92680290cd34bf30bfef0cc1aa.1685440589.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8e152cd504552e92680290cd34bf30bfef0cc1aa.1685440589.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:owL36V0PNbO2K/aOB/y/PbuUt1X33g6Qkdb+pShNP7zpC2HmJdk
 HlQI8YKO/lLs+bZiAwf+7X5tlI/ouIYmEC/yN7Co1qehNjTD9/f/Jjmn3ZRXUUGNV5XQLay
 nfzdISe09GcPCVuhfhY9xWbmTpxzh1BSRApFlgJ0jJen4U64JJbJ3z35M07icif9Lu8L16f
 NXawyqwqEmBXbJwf39IIg==
UI-OutboundReport: notjunk:1;M01:P0:frJvtd3d2zQ=;zLgRbsCR8FdHMJQX/qBUNFCDsjg
 ehFcZBgr13W/eevZCmI7JbuoU+/ca36fXCfJglY9fJvyXglW607FG1e416DWGxtIoua4QDQQZ
 On668N4Nb2jZvCsC4PXWqM77b/MlS/iKHZOpI7rloqZWTTgR5SgnPNOoyu1i/GOfVXfTaEkk/
 OkJZOSEr2QjUkXJWWiksWzePIWEfxPWgF5ddssS8uLwtH1w4JEbll+ssde03Fe3LCqp9EQFga
 BZ48VPbx/Vzl2dlz/AqgbSh5WQa/RlbYbHIkkbHvraHvGzgDeLaOW9Skc3I6RPCAHg3SRRds9
 Mjkpbvdb6X8DxowJutr+DG2TE/5XKdYkXESsRsqCSUbGYlBit43ELVG8ldQBm4pcDBQgIlWss
 n3LlFPRlkTyZ9MjrrKxRZMjoxi3Afyj6ISDkxR3iA0RWfht543735NDA6hO0QLVJp9A6LZubS
 Cg3Un6QRrkj0qBbD1feJ3zLFUd5NAPZCOhPLbX3Cpu4vILU2l9cgm0TlXzaNPybCAqYzAaPbT
 rYitPtp4u1GR+BLEPGmwdykc8ENS74ye95kP8I04EdhDeoOHLGUsLjiwgmVDqbowvI44y/gX+
 57//yifzfdnR1fdyWCtkjzeO9trzf8fMjSvuFZUGlPSGi+fACwR7MY00B2cVRuMcA0HxNji+Y
 4IBGjPMCTK3FyokVmu8CH1DBi4tTgU9SSwn2rvCrnain9EKaBJhXuBhHS9/kXd8fW5gI8sZPH
 aWRdu5IlQ5oOKX5UaC9vHMoYQsauBicyt08ehqFqE23X+0C9URvC7ngfGJPutgCOBf32ZesVi
 /WjFKtO8PKVNoYiYlyQS/Dh3kQ69Jjr4LMSWk3Mws7S2Y3c4enN7qsAMLQtSz+N3fD/eq4jTj
 4uF+RWaR1yUCSYXCFbHxp61qY+v3EtbjfFPX5O30s7onqWNxPuYYNh+gJ/3a4felTRKx5k3+K
 Rqs1tn1wArL1zPQQ7d01jrMA4Nw=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/30 18:15, Anand Jain wrote:
> Add the DEF_SUPER_FLAG_ENTRY for CHANGING_FSID_V2 to our btrfs-progs'
> print-tree.c, as it is currently missing in the dump-super output, which
> was too confusing.
>
> Before:
> flags			0x1000000001
> 			( WRITTEN )
>
> After:
> flags			0x1000000001
> 			( WRITTEN |
> 			  CHANGING_FSID_V2 )
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

The patch itself looks fine.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   kernel-shared/print-tree.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> index aaaf58ae2e0f..623f192aaefc 100644
> --- a/kernel-shared/print-tree.c
> +++ b/kernel-shared/print-tree.c
> @@ -1721,6 +1721,7 @@ static struct readable_flag_entry super_flags_arra=
y[] =3D {
>   	DEF_HEADER_FLAG_ENTRY(WRITTEN),
>   	DEF_HEADER_FLAG_ENTRY(RELOC),
>   	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID),
> +	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID_V2),
>   	DEF_SUPER_FLAG_ENTRY(SEEDING),
>   	DEF_SUPER_FLAG_ENTRY(METADUMP),
>   	DEF_SUPER_FLAG_ENTRY(METADUMP_V2)
