Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0E506C20
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 14:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349981AbiDSMS1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 08:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352062AbiDSMSZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 08:18:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA02F2251C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650370231;
        bh=TLZNPJPkI9N2U8/fTi22KjLqW92eAinfVNEsSTzXBrg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=J+8KEazT+QIcrlHM31oyVP1mGfsgj6XsPoc2tc1kbrNNEYmP0uloCTMYB+l8m83vU
         rvaHVgkxsmoL4AI+APBkVlYA65zwEQFQt6hilbh8tz/Yx6egBaaZ+tAmLq1fKEusfZ
         +KfRbMjIWYE2M5D4XsbihoirbOHaqVJYkECwJsbc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1po0-1neapY4B44-002Ema; Tue, 19
 Apr 2022 14:10:31 +0200
Message-ID: <0a6a081d-52e0-b8b0-cc50-3f85e6c2c410@gmx.com>
Date:   Tue, 19 Apr 2022 20:10:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] btrfs-progs: do not allow setting seed flag on fs with
 dirty log
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <4022d9f87067124c26bb83d4bba1970c954cdf50.1650022504.git.wqu@suse.com>
 <3f94efa2-e53a-f032-6ff4-3b8994489b02@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <3f94efa2-e53a-f032-6ff4-3b8994489b02@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H+u79pBAJd78oz1IpMO6iF4vBE5/RntPMX6rm+NznAkBRRkkZzs
 5KzxIc7FiJdkx68urCLoaVbj+WkkxnMhX3RWTRwrgMAHH/quj2ax8qAC4oBPDbLI3FM04dF
 UtR/GfR/dcws468x+lbmUvPkrRDtrXS8rXRO0PQ9fTM8M+ckcmISGB7UJX/tuHi9UojWod7
 hJWSjpekf1b1LW5TEOOdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cyDIOpFQ/Qk=:Po4XoQpsMcke90VnQqEFhZ
 PacaEBCTDVEzigsh5SLvW41ov5Hp5uqcx9v0qZisaRiSY/+S0iIAzj7UfBEmAhdBzQ+x8gbnu
 erIc2FnqLqVgb2UlFMDx4ZYtOEcfw181Hzw5aVwWv3dwA/XyH8zs1WOwsgAvzbynSJzPFQGwB
 HxWtW9UPKwEAChbG0wNxJFcfHzh4Nn062tKORDrw2Mdee88KKNL6x9mOzr0sfSs+KcngLLt1B
 OjaHjsKCYB3QwTjp4ecnsUriSZJToDW9oaqCAjmAbiDfVpoDMQgU5y5r4ODtz/Dw8aREfV9ZB
 u8rRxI7aeYhqam+3iKQo/KE3x3kN/v22MX/TRVaFF41O+ShETZjpEJ0pYngAKZDvb/Sifk1wh
 933Wcj6kQPNq12dhTbN/bQ2fGZcBvy1GoIck1AnCeFiafkrSEaiXGlV3Jw/j40hrLe55AemSU
 4L7E///pSRh5dbAC0/1/6xtTq4PaTUtrUzu7jG5oF7/8SG5UxvMif+i0+kb5+V63YMzOcTR3H
 Sg4ghfthBDPxoQ9hfeB9nihjFBgH1hHSoInYuOpdzcRo5XUwxTwqKJF3RnznGEe3DcSoSOpRF
 XGG/V6g16rFYOTv4efu6RXV6zh67QLxqYiSfmPkaSmDvUgtsObFeBLaGkrrCt4NbDQjMLwgxW
 MkHkhY4A54JLXz8XMWWne2drkBehW47Uu2fF8V5DP0j8gJ1q6lnWWBM2bljs6hphb4k8Un/tW
 njTGpILFW+Y6/pBwfSX6OB/5Emc45MDlX846ktAgCGUSkDBNQoZB/5FAk55/5+H9JDlqwvTix
 30JGx7fBGrT2btZYMj79qB9y5ELA2N8qUv5Ce8h0dryTWqeFaDcAJFChLtB1P7JBlXAm6eqq1
 iBFEBSdT0rzQDu+h+/ibjT4VNXIvTLQk47pIAEur9dg4LE32dhsBbRfsc/K1+nHZWSZqU8pf2
 bEXQYKAKQoC0BvhtTXqbayX9YtMQwMO4lMPKO//uBWDwVFxF0l7KMCKjxF9FJMI2TOGi4/WW4
 EF1QSEGfDSVUq2J7CxWLMdYtYwiVohtebbUR05iVT0NtSKJZaxrnGNDt0MinfP50eF88fvGt2
 hjzBQlZU135Oac=
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/19 20:07, Anand Jain wrote:
> On 4/15/22 19:37, Qu Wenruo wrote:
>> [BUG]
>> The following sequence operation can lead to a seed fs rejected by
>> kernel:
>>
>> =C2=A0 # Generate a fs with dirty log
>> =C2=A0 mkfs.btrfs -f $file
>> =C2=A0 mount $dev $mnt
>> =C2=A0 xfs_io -f -c "pwrite 0 16k" -c fsync $mnt/file
>> =C2=A0 cp $file $file.backup
>> =C2=A0 umount $mnt
>> =C2=A0 mv $file.backup $file
>>
>> =C2=A0 # now $file has dirty log, set seed flag on it
>> =C2=A0 btrfstune -S1 $file
>>
>> =C2=A0 # mount will fail
>> =C2=A0 mount $file $mnt
>>
>> The mount failure with the following dmesg:
>>
>> [=C2=A0 980.363667] loop0: detected capacity change from 0 to 262144
>> [=C2=A0 980.371177] BTRFS info (device loop0): flagging fs with big
>> metadata feature
>> [=C2=A0 980.372229] BTRFS info (device loop0): using free space tree
>> [=C2=A0 980.372639] BTRFS info (device loop0): has skinny extents
>> [=C2=A0 980.375075] BTRFS info (device loop0): start tree-log replay
>> [=C2=A0 980.375513] BTRFS warning (device loop0): log replay required o=
n RO
>> media
>> [=C2=A0 980.381652] BTRFS error (device loop0): open_ctree failed
>>
>> [CAUSE]
>> Although btrfs will replay its dirty log even with RO mount, but kernel
>> will treat seed device as RO device, and dirty log can not be replayed
>> on RO device.
>>
>> This rejection is already the better end, just imagine if we don't trea=
t
>> seed device as RO, and replayed the dirty log.
>> The filesystem relying on the seed device will be completely screwed up=
.
>>
>> [FIX]
>> Just add extra check on log tree in btrfstune to reject setting seed
>> flag on filesystems with dirty log.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> LGTM.
>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
> a small nit below.
>
>> ---
>> =C2=A0 btrfstune.c | 4 ++++
>> =C2=A0 1 file changed, 4 insertions(+)
>>
>> diff --git a/btrfstune.c b/btrfstune.c
>> index 33c83bf16291..7e4ad30a1cbd 100644
>> --- a/btrfstune.c
>> +++ b/btrfstune.c
>> @@ -59,6 +59,10 @@ static int update_seeding_flag(struct btrfs_root
>> *root, int set_flag)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 device);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_super_log_root(di=
sk_super)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or("this filesystem has dirty log, can not set seed
>> flag");
>
> Also, add a note on how to overcome dirty log. Mount / unmount?

Mount/unmount or zero log.

I guess if a user has a dirty log (by itself is not that rare) and still
want to set seed flag on it (if the user doesn't understand what she/he
is doing, then it's a big problem), it's worthy to ask in the mailing
list already.

Thanks,
Qu
>
> Thanks, Anand
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 super_flags |=3D=
 BTRFS_SUPER_FLAG_SEEDING;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(super_flag=
s & BTRFS_SUPER_FLAG_SEEDING)) {
>
