Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354FB11FC50
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2019 01:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfLPAt7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Dec 2019 19:49:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:54201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfLPAt7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Dec 2019 19:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576457392;
        bh=X3DQloCObFqx3F21sZx9wXtI7b5qUowG/SFbO2XvOco=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Dszp4aL8xuBleHODWc81zZJ1K3ogX3RiCnXz59KnDsy7j9C4vLSstGD2TUFacG2tJ
         uUT9RoGEqo3MrFkmxZkjpU+GjbarLoRQUWj5DjDddr+s4n8G00wePyj62VWyBxZcje
         K++MFzkLDys+4o5qGSlSJfoXaknBHH39QNU3kCeI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.178] ([34.92.249.81]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJE2D-1iQvHI2Lnf-00Kd7j; Mon, 16
 Dec 2019 01:49:52 +0100
Subject: Re: [PATCH 0/6] btrfs: metadata uuid fixes and enhancements
To:     Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191212110132.11063-1-Damenly_Su@gmx.com>
 <f2a44405-9f5a-cf39-7f5b-149f160b65a6@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <bbd51a65-6616-cd6d-0183-93aa7b11ccb9@gmx.com>
Date:   Mon, 16 Dec 2019 08:49:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <f2a44405-9f5a-cf39-7f5b-149f160b65a6@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Otfs0kkWj5i8GWL2ziEJkzWLaXCRaitrA8vu45/mW8lTe95Yu9E
 ZZbM2DOwyMd6ouop6vdzKiHNt1Bha1KavECQV0JNl9PP+TnbQWvtq2aVLjLRhaMpmbQn+Zl
 wsTZOlfK6UIi1SkldNRktjsPdcijncr24v824YtSvFbVkGPt0e60dzTVF2D+Hj3RspZPeeC
 9q2PTjQ/n1VLiijV+k2mg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iGEexnnZ0/U=:XWGTh2XtiV6M46A6s0cVnb
 HjmastohPMA6KXg/K7jreHfLerye6mx/aHe9ls9GxRDzkR8etaZJwWCXrd4MJmH2ulcXXTk1W
 Te0YjzM8BBl8GoPAzHcffoUFcSYBiUq8vvejBxrDSVagGK7VzOsEzRMviXgQBdG1QATuKZqGP
 EewSsJ/S0IogFcGEPAoxOdKPsZwgq0ffZoKnH62fk6eo0ywjb6hpWxeznVRRy5esYDLenGK0C
 9TSuELHwaKWzOaA5DB1ryCj0Ivqsk6E/m4gyh8i2FOtGA5wCgkTyMsVeaGDu4z4GQ3PBHXwBy
 gDKq/h80ZwY7rZO/9RVmW36DsQyYZjZgVNT+hFnqPe38g9Fru2YdWva/t8Lb34q8ujfptrYf3
 gXF9MKdjL7r9qfAFzfGlkB8zcGKAqJxnPj1ciMT7xZqPwRmiXfS15JE6Dgc755dG+FIpZ17ht
 qbV9JC+LMH5C0QeEUl3SGRvEBZt7Vh3zUTeH71mQzymztuCq8cqzLv8RDt1NsdVpuIO36uwlE
 IYZjJ6FPE/9giV42ahjiiZbBH2WpDFG74uB5aHEerfIXHic6oNq30CFwoMB8ellt4NxLaCoWi
 x+NcOKGS78AKSmDncUonHDbsPp8dNXJI5neiCWciS72ljjJ/5JBAHCZgKfI1n5AgqhvcNFrdC
 4uh8kbGmsAM4A4bFc/gMjd7GNbt73pPMdVGIHWdNOS9MK0UpZC5Zj0g69NvDTb0sF9EvSI/tN
 FDYPPGHwavzlZ7c+qQx+Xd++ApAr+orbClIiY0RB7JVwPwIrXE69Vnd1IRYi1k8PWtE9SCK1I
 7eOgXnD88J9Fa+0LAaYJllroQmODG6PZtr6T7gS0BdZW8r2Io4DRYa+ePPRSIdptnSObRixZs
 I5s+5znT4zbff8PoquyjtpWq/Kl29wE3Yue2WNSOUdcpVX/okBAifMEQoLL/2++5ZFVlrJBXm
 LucQrB8SRuLJescsnKw2/BCXOCh0D5gDW0z7qZv7KxxHFIrChbOhzvJavGDzKZDzw2C04Fa4k
 mUWEyDLzIwYKbIeWZJjpi0AVTEaLgkN2LRQPUMm/zeiIyieRE5xU8Qfp7ieDYpuqtoX5yQzrq
 lPq6GzVlBUsBYNLru/zcBSUiNApIwXcpLLJMfO3kxUMzz4L4Iwox8Dq1DdUwXeA0SSXyUAqYF
 MdzG9h/sdXqVEAA//Dvqi3kaFRHMCby+0hjNG/CLNQ1LBnFiWgwy2NevIJR6xiQRRS1gvjA8V
 OzBy5dJQ8lOm5Q038tdY7ZXjJoaW+IlVOyD51HwyU+8v45jRVRAyIewJW/ZY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019/12/13 4:03 PM, Nikolay Borisov wrote:
>
>
> On 12.12.19 =D0=B3. 13:01 =D1=87., damenly.su@gmail.com wrote:
>> From: Su Yue <Damenly_Su@gmx.com>
>>
>> This patchset fixes one reproducible bug and add two split-brain
>> cases ignored.
>>
>> The origin code thinks the final state of successful synced device is
>> always has INCOMPAT_METADATA_UUID feature. However, a device without
>> the feature flag can be the one pull into disk. This is what handled
>> in the patchset. Test images are added in btrfs-progs part.
>>
>> Patch[1] fixes a bug about wrong fsid copy.
>> Patch[2] is for the later patches.
>> Patch[3-5] add the forgotten cases.
>> Patch[6] just does simple code movement for grace.
>>
>> The set passes xfstests-dev without regressions.
>>
>> Su Yue (6):
>>    btrfs: metadata_uuid: fix failed assertion due to unsuccessful devic=
e
>>      scan
>>    btrfs: metadata_uuid: move split-brain handling from fs_id() to new
>>      function
>>    btrfs: split-brain case for scanned changing device with
>>      INCOMPAT_METADATA_UUID
>>    btrfs: split-brain case for scanned changed device without
>>      INCOMPAT_METADATA_UUID
>>    btrfs: copy fsid and metadata_uuid for pulled disk without
>>      INCOMPAT_METADATA_UUID
>>    btrfs: metadata_uuid: move partly logic into find_fsid_inprogress()
>>
>>   fs/btrfs/volumes.c | 193 +++++++++++++++++++++++++++++---------------=
-
>>   1 file changed, 125 insertions(+), 68 deletions(-)
>>
>
>
> I'm currently on holiday but the fsid change feature has a design
> document here:
> https://github.com/btrfs/btrfs-dev-docs/blob/master/fsid-change.txt
>
> it lists all the cases I have handled. If you think there are other
> please first describe them in prose following the parlance set out in
> the document to ease reasoning.
>

Thanks. I am going to do it.
The following is just a rough version for people to understand.
The pull request version will be more official like expressions in
btrfs-dev-docs.


 > 4. Failure during transaction x + 1. When such a failure happens the
 > filesystem in question will be partitioned in two sets P and Q. Where P
 > would have the C flag and a new value for fsid written to it as well
as the
 > old FSID value written in the =E2=80=98metadata_uuid=E2=80=99 field. In=
 contrast Q would
 > have just the old fsid and the IP flag, also the superblock=E2=80=99s g=
eneration
 > number of disks in P will be higher than those in Q. Again two cases
needs
 > to be handled:

I won't argue the Q has the old fsid and IP flag. There is another state
of P.


0) There are two devices with fsid A, without metadata_uuid. E.g
        d1[A, 0, 0]
        d2[A, 0, 0]
        (The first element is the FSID, the 2nd is METADATA_UUID, the 3rd =
is
         the incompat flag bits)

1) After running "btrfstune -M B":
        d1[B, A, METADATA_UUID]
        d2[B, A, METADATA_UUID]

2) During "btrfstune -M a",
2.1) After first btrfs_commit_transaction() of set_metadata_uuid() finishe=
d:

        d1[B, A, METADATA_UUID | FSID_CHANGING_V2]
        d2[B, A, METADATA_UUID | FSID_CHANGING_V2]

2.2) Then run into the branch  btrfstune.c: line 141.

	    if (new_uuid && uuid_changed && memcmp(disk_super->metadata_uuid,
                                                new_fsid,
BTRFS_FSID_SIZE) =3D=3D 0) {
                 /*
                  * Changing fsid to be the same as metadata uuid, so just
                  * disable the flag
                  */
                 memcpy(disk_super->fsid, &new_fsid, BTRFS_FSID_SIZE);
                 incompat_flags &=3D ~BTRFS_FEATURE_INCOMPAT_METADATA_UUID=
;
                 btrfs_set_super_incompat_flags(disk_super, incompat_flags=
);
                 memset(disk_super->metadata_uuid, 0, BTRFS_FSID_SIZE);

      Now @disk_super is [A, 0, FSID_CHANGING_V2], without METADATA_UUID
flag.

2.3) Then we go to the final btrfs_commit_transaction() of
set_metadata_uuid().
      But powerloss happened, and only d1 get synced:

       d1[A, 0, 0]                                 ---> P
       d2[B, A, METADATA_UUID | FSID_CHANGING_V2]  ---> Q



      So there are 2 cases you forgot to consider.
      - P is scanned first, then Q.
      - Q is scanned first, then P.


