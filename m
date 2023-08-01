Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A77976A593
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 02:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjHAAb6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 20:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjHAAb5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 20:31:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18033133
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690849907; x=1691454707; i=quwenruo.btrfs@gmx.com;
 bh=5X0Ll0MlW3gFFb8e8qP737ETMtW8WhZC6X98rr4rCck=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=DfcJB28HL/TStknch9BlWKF7D1G15NQ6oy167WNRkwUdX1dEE9ZtLANfLOUe51HiS/f9h+n
 ujtyC1jb3anqQ4RdLFWrIxWSS9mNfJqu0Dwk8SzRIApNK9jDCjVAHtydk5I2k1rUq2BQI2iNh
 5cMNsIXprBAVcCBaGwoO2SRR3ijxmbMxhYKi/aJbt5sDHQG/BlVg5gVOtisW5jBehSdLROJUI
 Cd2C2lW9ibMcAxMksoVN6zKuUPRNdX/lA/S5RsQCC8AMBd36wUknHHE2YJrgJ1TLzz2tUgjRg
 fcEBgF6sYsj0Mv6wPhCHqS5ZXhn7uDdMy06luOZY0XAfSTvaH4Lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUjC-1paS9Y447W-00rU7j; Tue, 01
 Aug 2023 02:31:47 +0200
Message-ID: <319157cb-525a-38ad-be53-10f929b6dba3@gmx.com>
Date:   Tue, 1 Aug 2023 08:31:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: output extra debug info if we failed to find an
 inline backref
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <5e4c3eaf235f8a73054f06d8fa68673566a5b323.1690783136.git.wqu@suse.com>
 <CAL3q7H5UHX9SD8vzsWAKERAp=f8JJJWKXa9zPg6g84O9ATA_UA@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H5UHX9SD8vzsWAKERAp=f8JJJWKXa9zPg6g84O9ATA_UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jwyrghdYnQnTDWtfcee+Z8YLRDDG3mXS7OpSkJBK9RCVwweeSYN
 TCOGyfuCAsGZECPvB7XS39+dj4Pw6tMyWlk05tqdsx9idHCYNHlrbSMI9MOKm++cdrVq/iK
 k7XiTTvRX7YwavMOESc/KCt0vUK6lcln3/e1MrSIYFlSIWwKyd8qfXBBLTxegTbRqYdSRlf
 Bd36JPmZjdpc1KznC0W+g==
UI-OutboundReport: notjunk:1;M01:P0:8HZd9x8Z13E=;izosuI4YcdzIaASjGTFnu4/b8A4
 jC34H5GGK0N0war0BZvMsNEQg/cFYcXDcSaBP2mWaNBFpE5kxoem9ZpsipvDhbUeCF7sYzKhI
 SYMOLt/7j1KBz6fueuYOUWR5KAaTiiN430HUJlnh+x4PDth+Rrq080z/Jq/w+bc+BYGJw2Vcj
 xVgSdv3C/8blMo9lGvI37BLbJma6/PsNsLEQ3SymX5tKqewY6SfFlkxgymEck05hm++GilmFN
 nyCL7m29xIQvHuWMjxhg9NVba1abmEzEZ/bwAlkuGwIk21jKiCilEAoOSg+REwBjTw88fPUlS
 8KNY1MULREZWCGRG52o5lMX4jRA3h3OrVJ3Fjj/2PbNAviaSjq1IlBooMvqbvXlTPaTWmyAee
 e9q/yxXMF5vU6nDCpuu9LTnIh33Jzh2ZwaSKiWdM3737MW8dT/s59J/KTn5oHVtAyIyop5zoz
 ZlHqvniOm+4TI+yFPWQAzRJ8YXiyeOx1Ke2OwYyboJx0ADzu0BE90B7J2D9vIUJtp7n9Aaddi
 3BlDF7b9LdBqTo73zRMnBo7qIXQFc4dNLlesWf8/+2Ut7FcgPOYU9Dni2s5RmXNnCVn9d4qZn
 213HC8FyaeycSfg9r6jECeH2Kqn0UckEDlz+eEw8RDaG1PjbUmmpXydFfOkFEFpBxsUZ2NuJM
 vpi8UM97RTOx5YedapCxo6abJR241/1rAor1QBJtND1GH/kbieACpBtqcUWjOT8o05sRtO1ZC
 LkBtgbiW8ox8fTKA5bBhuXg4Nrme6wdctSN/Xw8XZska63OAPebuoJTg1flwJRBqJRiv6KDf8
 DWkRxdkm+yZHGEZD3LacjTSamrVfTZQWsPLtCUUaHV//Ut/R6VLL9Nz256eSGqxfvSJuUosoc
 OQpO81kyaroZIo0lr4AZefGj3/1ThBY4LkXqJ62OjOgmeZFM6ZxKGKS03WZJ7+FCVV8sIBkYh
 tVGpTQCCgBXEQZXv+atTVTH5u94=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/31 20:06, Filipe Manana wrote:
> On Mon, Jul 31, 2023 at 7:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> Syzbot reported several warning triggered inside
>> lookup_inline_extent_backref().
>>
>> [CAUSE]
>> As usual, the reproducer doesn't reliably trigger locally here, but at
>> least we know the WARN_ON() is triggered when an inline backref can not
>> be found, and it can only be triggered when @insert is true. (aka,
>> inserting a new inline backref, which means the backref should already
>> exist)
>>
>> [ENHANCEMENT]
>> Instead of a plain WARN_ON(), dump all the parameter and the extent tre=
e
>> leaf to help debug.
>>
>> Link: https://syzkaller.appspot.com/bug?extid=3Dd6f9ff86c1d804ba2bc6
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent-tree.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 3cae798499e2..51a721b7156e 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -847,7 +847,13 @@ int lookup_inline_extent_backref(struct btrfs_tran=
s_handle *trans,
>>          if (ret && !insert) {
>>                  err =3D -ENOENT;
>>                  goto out;
>> -       } else if (WARN_ON(ret)) {
>> +       } else if (unlikely(ret)) {
>> +               btrfs_err(fs_info,
>> +"inline backref not found, bytenr %llu num_bytes %llu parent %llu root=
_objectid %llu owner %llu offset %llu",
>> +                         bytenr, num_bytes, parent, root_objectid, own=
er,
>> +                         offset);
>> +               btrfs_print_leaf(path->nodes[0]);
>> +               WARN_ON(1);
>
> The error messages should be printed after dumping the leaf.
> This is what we generally do to make sure the message is seen on logs
> from screenshots sometimes sent by users.
>
> For the same reason, the WARN_ON() should also happen before the error m=
essage.
> Also why did you remove it from the else-if statement? WARN_ON()
> already uses 'unlikely'.

I thought the "if (WARN_ON())" pattern is not recommended anymore.

But I'm totally fine going back to the existing one.

Thanks,
Qu
>
> Thanks.
>
>>                  err =3D -EIO;
>>                  goto out;
>>          }
>> --
>> 2.41.0
>>
