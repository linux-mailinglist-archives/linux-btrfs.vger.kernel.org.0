Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8E158F787
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Aug 2022 08:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiHKGWT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 02:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiHKGWS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 02:22:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC877D7B5
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 23:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660198925;
        bh=pDePluPPnM1jd0EuRdNmdKe4bCoC8jRAfZIJjSV+NXk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kdz55qeiZgUN/WxTQwFle5DmbltoLjr61quNmOItTRG3kHx7zml10zDHs+EGICESp
         gz3kfMfO1/oPEer4g2G0Hl+C7UFcSRLe/7LE6WkKK8b/g5vIEquXL0dQTmxOOiypPF
         Uoex3i85AqOiM/ydhXG+3TAL4enKf9tp5nnxb98s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzOm-1o1E0W1tIi-00POY8; Thu, 11
 Aug 2022 08:22:05 +0200
Message-ID: <5d90f06e-0ee0-4744-0c84-c8cddf2edef2@gmx.com>
Date:   Thu, 11 Aug 2022 14:21:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] btrfs-progs: Fix seed device bug for btrfs249
Content-Language: en-US
To:     hmsjwzb <hmsjwzb@zoho.com>, anand.jain@oracle.com,
        nborisov@suse.com
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, clm@fb.com
References: <20220810073347.4998-1-hmsjwzb@zoho.com>
 <d410d2f3-497c-d79b-f413-fbacc9211fac@gmx.com>
 <548b9707-1fbd-c906-b195-3b8ffe93863e@zoho.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <548b9707-1fbd-c906-b195-3b8ffe93863e@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2MlfDhKKHrVSC4CZ4en7M7r2r+asxaZw0l0aYQRSRk+jIlNcR/L
 rwlabVQal594cH7oDVquJWwKtK0INK4jWFGhsqCtiernBc66w0ULGTi7HL55w2h77N5qISf
 v5BosaL2AWBE3pfh5oZnJNB1I6WVlUh0teluH+NGjhfdMZ6Gaoido4N1EcTGrgSn8zEw5i5
 W8lfpn0w73Gs8EIpR+RwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EFb4WlRjw78=:Oa5hifDyvPk+913YpNevam
 ESRqdvjB54W6n1AR7riAyitnIAHRTU57j5WIRl9SHBV1jUuM9hk2Bkv/J+MfDo/N8hJ4iCizY
 gCZFa+PSwdaWcf4rsrC/ro7AlsSgDNlcq5LNqxbppy96Xx0CQqi9X6u0ntirpLsl9lhYeF2D4
 6pEWGUv9VXj6H4bImCPByLzoPKrtD2kohofAmqrfDx3+UXoP5kyfVtB3mdKPXS/LfAS8XTcmC
 /bKK1ifAzfyZMy7IC7XvvlffTRBTNoH1RGuChPX4IfXYP3HpOuUC0YI7Kpm+r9X6/7ytKXnmX
 pzWlZw/Km9QhGjOz9ud+Vecx3E2SSU6FDgLcNpMa7KCXpQL89gFXt+teEXLfwKu/xsa0YVo3b
 GCu7ajFvl9/Gzxirw7/o0SS+XdZcJJYh4K6+D/VE52bPkqw1GZuhKMtay8VG4qOaHOd8PJWrv
 ZjN7shAe8EMecOrsukQ+GbgCJG0QsSKKhRdjxFyMA9UH5ydSiz1eg3yOSsi68qukJDA5mZRb6
 VAR4Hwe5+munMnJZ7L207ysRr9rHTlp101KHHZCvXugxI4bQ6VeoniSP2O67sufCS/IJzWyoC
 uslNqFoCz9DnwM3V02QujDcR6zZo4F+iTlP3YPSXRVvjhHav4PxbozzjRFp6eKo053vRGklAz
 HFYICVzAHnP5H46tngfs0kPI8eC6N61aeiqZuNU2J2E4ZjmPWsb9j3NB7WhgiC8Vy6z0IoltV
 OOMR1dNyBHRhmZOmMLtS95BMVjGblNYjlAU4BIzrAgwKnA5CDOPw1sMeXH1gCyRDFKZ9LUzrM
 rTexBK7ua4KLxKyXMmvKzMh/CxQe9oydh7+jV/NOXmFiLbBrwQ9FpCvwBRev9vBa0r3PuQa4J
 ihddVI21VQ4x3fln7RlMGvM4JoUBFSyajziOpEq16o6gTQb1xujT1WjO1w04bdvsZYjJxOqnB
 29WETaYMu5w9jEmDzpAxnuHkr41iETMNPsX2/NU//2Z9VOUnDbdE67rTiLr6HOTVm1ZbLFCEK
 ALOjDniBfnm9PB8xK9AFGwefwguaBovqZ2+/qrK9R1jq2Nart92TAvgu2BP5syrkXnTPSCbZK
 VOGFGOSpQTEHYkbFbRYh4xpocRispGMctmWLfd4yG2M30L/LpH35JqCNQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/11 14:07, hmsjwzb wrote:
> Hi Qu,
>
> Thanks for you reply. I am working on the tree-search based solution.
> I have got the btrfs_dev_item from the chunk tree.
> But I don't know how to tell whether it is a seed device.

You can check the fsid.

Seed device has a different fsid than the one returned by BTRFS_IOC_FS_INF=
O.

Thanks,
Qu

> Do you have some solution to tell whether it is a seed device or not?
>
> Thanks,
> Flint
>
> On 8/10/22 03:56, Qu Wenruo wrote:
>> Commit message please.
>>
>> On 2022/8/10 15:33, Flint.Wang wrote:
>>> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
>>> ---
>>>  =C2=A0 cmds/device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +-
>>>  =C2=A0 cmds/filesystem-usage.c | 10 +++++-----
>>>  =C2=A0 cmds/filesystem-usage.h |=C2=A0 2 +-
>>>  =C2=A0 common/utils.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 9 +++++----
>>>  =C2=A0 common/utils.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 2 +-
>>>  =C2=A0 ioctl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>>>  =C2=A0 6 files changed, 15 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/cmds/device.c b/cmds/device.c
>>> index 7d3febff..81559110 100644
>>> --- a/cmds/device.c
>>> +++ b/cmds/device.c
>>> @@ -752,7 +752,7 @@ static int _cmd_device_usage(int fd, const char *p=
ath, unsigned unit_mode)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int devcount =3D 0;
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D load_chunk_and_device_info(fd,=
 &chunkinfo, &chunkcount, &devinfo,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &d=
evcount);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &d=
evcount, false);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>
>>> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
>>> index 01729e18..b2ed3212 100644
>>> --- a/cmds/filesystem-usage.c
>>> +++ b/cmds/filesystem-usage.c
>>> @@ -693,7 +693,7 @@ out:
>>>  =C2=A0=C2=A0 *=C2=A0 This function loads the device_info structure an=
d put them in an array
>>>  =C2=A0=C2=A0 */
>>>  =C2=A0 static int load_device_info(int fd, struct device_info **devic=
e_info_ptr,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int *device_info_count)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int *device_info_count, bool noseed)
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret, i, ndevs;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_ioctl_fs_info_args fi_arg=
s;
>>> @@ -727,7 +727,7 @@ static int load_device_info(int fd, struct device_=
info **device_info_ptr,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&dev_in=
fo, 0, sizeof(dev_info));
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D get_device_info(fd=
, i, &dev_info);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D get_device_info(fd=
, i, &dev_info, noseed);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D=
 -ENODEV)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>>> @@ -779,7 +779,7 @@ out:
>>>  =C2=A0 }
>>>
>>>  =C2=A0 int load_chunk_and_device_info(int fd, struct chunk_info **chu=
nkinfo,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *chunkcount, struct de=
vice_info **devinfo, int *devcount)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *chunkcount, struct de=
vice_info **devinfo, int *devcount, bool noseed)
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>
>>> @@ -791,7 +791,7 @@ int load_chunk_and_device_info(int fd, struct chun=
k_info **chunkinfo,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0 ret =3D load_device_info(fd, devinfo, devcount);
>>> +=C2=A0=C2=A0=C2=A0 ret =3D load_device_info(fd, devinfo, devcount, no=
seed);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -EPERM) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warning(
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "cannot get fi=
lesystem info from ioctl(FS_INFO), run as root");
>>> @@ -1172,7 +1172,7 @@ static int cmd_filesystem_usage(const struct cmd=
_struct *cmd,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 printf("\n");
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D load_c=
hunk_and_device_info(fd, &chunkinfo, &chunkcount,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &devinfo, &devcount);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &devinfo, &devcount, true);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto cleanup;
>>>
>>> diff --git a/cmds/filesystem-usage.h b/cmds/filesystem-usage.h
>>> index cab38462..6fd04172 100644
>>> --- a/cmds/filesystem-usage.h
>>> +++ b/cmds/filesystem-usage.h
>>> @@ -45,7 +45,7 @@ struct chunk_info {
>>>  =C2=A0 };
>>>
>>>  =C2=A0 int load_chunk_and_device_info(int fd, struct chunk_info **chu=
nkinfo,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *chunkcount, struct de=
vice_info **devinfo, int *devcount);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *chunkcount, struct de=
vice_info **devinfo, int *devcount, bool noseed);
>>>  =C2=A0 void print_device_chunks(struct device_info *devinfo,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct chunk_i=
nfo *chunks_info_ptr,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int chunks_inf=
o_count, unsigned unit_mode);
>>> diff --git a/common/utils.c b/common/utils.c
>>> index 1ed5571f..72d50885 100644
>>> --- a/common/utils.c
>>> +++ b/common/utils.c
>>> @@ -285,14 +285,15 @@ void btrfs_format_csum(u16 csum_type, const u8 *=
data, char *output)
>>>  =C2=A0 }
>>>
>>>  =C2=A0 int get_device_info(int fd, u64 devid,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_ioctl_dev_inf=
o_args *di_args)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_ioctl_dev_inf=
o_args *di_args, bool noseed)
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long req =3D noseed ? BTRFS_IOC_DEV_INFO_=
NOSEED : BTRFS_IOC_DEV_INFO;
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 di_args->devid =3D devid;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&di_args->uuid, '\0', sizeof(di=
_args->uuid));
>>>
>>> -=C2=A0=C2=A0=C2=A0 ret =3D ioctl(fd, BTRFS_IOC_DEV_INFO, di_args);
>>> +=C2=A0=C2=A0=C2=A0 ret =3D ioctl(fd, req, di_args);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret < 0 ? -errno : 0;
>>>  =C2=A0 }
>>>
>>> @@ -498,7 +499,7 @@ int get_fs_info(const char *path, struct btrfs_ioc=
tl_fs_info_args *fi_args,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * search=
_chunk_tree_for_fs_info() will lacks the devid 0
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so man=
ual probe for it here.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D get_device_info(fd=
, 0, &tmp);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D get_device_info(fd=
, 0, &tmp, false);
>>
>> No, I don't think we should go that complex.
>>
>> The root cause is pretty simple, btrfs_ioctl_fs_info() just return RW
>> devices for its fi_args->num_devices.
>>
>> This is fine for most cases, but for seed devices cases, we can not rel=
y
>> on that.
>>
>>
>> Knowing that, it's much easier to fix in user space, do a tree-search
>> ioctl to grab the device items from chunk tree, then we can easily chec=
k
>> the total number of devices (including RW and seed devices).
>>
>> With that info, we even have the FSID of each devices, then we can call
>> btrfs_ioctl_dev_info() to get each device.
>>
>>
>> I'd like to have a better optimization, to skip above chunk tree search=
,
>> but I don't have a quick idea on how to determine if a fs has seed devi=
ces.
>>
>>
>> Another more elegant solution is to make btrfs_ioctl_fs_info_args to
>> include one new member, total_devs, so that we can get rid of all the
>> problems.
>>
>> But for compatibility reasons, above tree-search based solution is stil=
l
>> needed as a fallback.
>>
>> Thanks,
>> Qu
>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fi_args->num_devices++;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ndevs++;
>>> @@ -521,7 +522,7 @@ int get_fs_info(const char *path, struct btrfs_ioc=
tl_fs_info_args *fi_args,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(di_args=
, &tmp, sizeof(tmp));
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (; last_devid <=3D fi_args->max_id=
 && ndevs < fi_args->num_devices;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_dev=
id++) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D get_device_info(fd=
, last_devid, &di_args[ndevs]);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D get_device_info(fd=
, last_devid, &di_args[ndevs], false);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D=
 -ENODEV)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>> diff --git a/common/utils.h b/common/utils.h
>>> index ea05fe5b..de4f93ca 100644
>>> --- a/common/utils.h
>>> +++ b/common/utils.h
>>> @@ -68,7 +68,7 @@ int lookup_path_rootid(int fd, u64 *rootid);
>>>  =C2=A0 int find_mount_fsroot(const char *subvol, const char *subvolid=
, char **mount);
>>>  =C2=A0 int find_mount_root(const char *path, char **mount_root);
>>>  =C2=A0 int get_device_info(int fd, u64 devid,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_ioctl_dev_inf=
o_args *di_args);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_ioctl_dev_inf=
o_args *di_args, bool noseed);
>>>  =C2=A0 int get_df(int fd, struct btrfs_ioctl_space_args **sargs_ret);
>>>
>>>  =C2=A0 const char *subvol_strip_mountpoint(const char *mnt, const cha=
r *full_path);
>>> diff --git a/ioctl.h b/ioctl.h
>>> index 368a87b2..e68fe58d 100644
>>> --- a/ioctl.h
>>> +++ b/ioctl.h
>>> @@ -883,6 +883,8 @@ static inline char *btrfs_err_str(enum btrfs_err_c=
ode err_code)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_ioc=
tl_scrub_args)
>>>  =C2=A0 #define BTRFS_IOC_DEV_INFO _IOWR(BTRFS_IOCTL_MAGIC, 30, \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_ioc=
tl_dev_info_args)
>>> +#define BTRFS_IOC_DEV_INFO_NOSEED _IOR(BTRFS_IOCTL_MAGIC, 30, \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btr=
fs_ioctl_dev_info_args)
>>>  =C2=A0 #define BTRFS_IOC_FS_INFO _IOR(BTRFS_IOCTL_MAGIC, 31, \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btr=
fs_ioctl_fs_info_args)
>>>  =C2=A0 #define BTRFS_IOC_BALANCE_V2 _IOWR(BTRFS_IOCTL_MAGIC, 32, \
