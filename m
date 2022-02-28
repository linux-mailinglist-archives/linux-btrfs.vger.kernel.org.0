Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22204C6D81
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 14:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiB1NOw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 08:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiB1NOt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 08:14:49 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF19774626
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 05:14:07 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cm8so17557674edb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 05:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Awv1bhitlBKTGF9LGms1JC0mZOAGCbooQ9UZmz0W20Y=;
        b=WBX0oz93f/x4Z0F8jFr7kzdOQSOoaMG7eJuhgACQl6PkXtbRZY77fUqtuFWCrXw3N/
         LuICWt+HL0HLC1p/+uCep2gqXlk2OEtk3GlEgH44CotUrcWxMrnjjpSjrX5dGbz9gkqn
         1iFQYjtlrSlMtbp1kVoOb7o3CRsZ9nuCFUSuki48FfSGJMVbl+Mj5zqNH0eThkWFmY9s
         MJJTleUMyb/ccuRWX1JToj+YDvEKxJY8M/e74fMS/mzOXWLxgwUVt3htLuhX7dODH44H
         ko1gGnl/OFUlmC2aYflt/odK9TfdiNxSnV3Gq9QKRs9B90ROGCymzWckswhY/Tgvqb1r
         R0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Awv1bhitlBKTGF9LGms1JC0mZOAGCbooQ9UZmz0W20Y=;
        b=F1O6ODBnVDaUQnviYVODm8tF+HqypnxqcboC5DYA92gfWWqFE/rrGJPB/D2kTG1QvG
         HS1HfyCLAssejN4OSBJKUZxvoRCCCUZHlHMc69bYj2baydiPEcYIFvaK3UHIUezBSNUc
         ba+rhmuSyq8EkxzpdsYcPASzZxfCX38ITkquuAfsIH81e+d+PPNgIgGQ0MnsIKjyu7V3
         hrtMQqaCvNelkjax+wlSLyW5iR/jIQTbKIMA54BeY0ivf6Ov6CCn+1HjEpWQ8HvAQ6s4
         VPQmaBdvdBUhbL4xSV2cWz3JiOjU4ElVBqDl1JGUBQQDm+YhqI1poZ1N9t0Ta3xEMi6t
         fMyg==
X-Gm-Message-State: AOAM531LGyeR25SdJRDudzDXUUs/6CZcPYhj2Fo9PvgA+sf9cfK5Yw5F
        qiYva//naDWKlfoJ53/QIy5AwdCc0r7mjGkHqTs=
X-Google-Smtp-Source: ABdhPJzhuNuvz+mAIC0acomSzs1N6x3mcGzQyMSgA9feiDRw7pSMdPyMNWdbE6r82qoWfffm/II50bRaLJu/swud55s=
X-Received: by 2002:a05:6402:520c:b0:412:7f7d:b06b with SMTP id
 s12-20020a056402520c00b004127f7db06bmr19955585edd.91.1646054045716; Mon, 28
 Feb 2022 05:14:05 -0800 (PST)
MIME-Version: 1.0
References: <732d0a86c3624bc96df3cca05512edac40efc75d.1646031785.git.wqu@suse.com>
 <ebdb0e67-0e9e-4ca6-1d2e-4dd2a7a7c103@oracle.com> <a6923955-00f9-d739-c70a-3beace0b85e1@gmx.com>
 <82df81f6-74a1-b77d-c4e9-48d20ab1bd68@oracle.com> <f8c0610e-466b-256b-347f-d10c517023ae@gmx.com>
 <c8009e2d-7569-4dec-3745-e9c3718ec57c@oracle.com> <07588d0a-293b-643e-f2c5-ebeb74023c4b@gmx.com>
In-Reply-To: <07588d0a-293b-643e-f2c5-ebeb74023c4b@gmx.com>
From:   =?UTF-8?Q?Luca_B=C3=A9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>
Date:   Mon, 28 Feb 2022 14:13:54 +0100
Message-ID: <CA+8xDSqppu9yDqKbKZNPrwE2zJy9MPB6NM-WCuoZTDQ4-=r6EA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: repair super block num_devices automatically
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Mo., 28. Feb. 2022 um 14:03 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.co=
m>:
>
>
>
> On 2022/2/28 20:51, Anand Jain wrote:
> > On 28/02/2022 17:21, Qu Wenruo wrote:
> >>
> >>
> >> On 2022/2/28 17:01, Anand Jain wrote:
> >>> On 28/02/2022 16:54, Qu Wenruo wrote:
> >>>>
> >>>>
> >>>> On 2022/2/28 16:00, Anand Jain wrote:
> >>>>> On 28/02/2022 15:05, Qu Wenruo wrote:
> >>>>>> [BUG]
> >>>>>> There is a report that a btrfs has a bad super block num devices.
> >>>>>>
> >>>>>> This makes btrfs to reject the fs completely.
> >>>>>>
> >>>>>>    BTRFS error (device sdd3): super_num_devices 3 mismatch with
> >>>>>> num_devices 2 found here
> >>>>>>    BTRFS error (device sdd3): failed to read chunk tree: -22
> >>>>>>    BTRFS error (device sdd3): open_ctree failed
> >>>>>>
> >>>>>> [CAUSE]
> >>>>>> During btrfs device removal, chunk tree and super block num devs a=
re
> >>>>>> updated in two different transactions:
> >>>>>>
> >>>>>>    btrfs_rm_device()
> >>>>>>    |- btrfs_rm_dev_item(device)
> >>>>>>    |  |- trans =3D btrfs_start_transaction()
> >>>>>>    |  |  Now we got transaction X
> >>>>>>    |  |
> >>>>>>    |  |- btrfs_del_item()
> >>>>>>    |  |  Now device item is removed from chunk tree
> >>>>>>    |  |
> >>>>>>    |  |- btrfs_commit_transaction()
> >>>>>>    |     Transaction X got committed, super num devs untouched,
> >>>>>>    |     but device item removed from chunk tree.
> >>>>>>    |     (AKA, super num devs is already incorrect)
> >>>>>>    |
> >>>>>>    |- cur_devices->num_devices--;
> >>>>>>    |- cur_devices->total_devices--;
> >>>>>>    |- btrfs_set_super_num_devices()
> >>>>>>       All those operations are not in transaction X, thus it will
> >>>>>>       only be written back to disk in next transaction.
> >>>>>>
> >>>>>> So after the transaction X in btrfs_rm_dev_item() committed, but
> >>>>>> before
> >>>>>> transaction X+1 (which can be minutes away), a power loss happen,
> >>>>>> then
> >>>>>> we got the super num mismatch.
> >>>>>>
> >>>>>
> >>>
> >>>
> >>>>> The cause part is much better now. So why not also update the super
> >>>>> num_devices in the same transaction?
> >>>>
> >>>> A lot of other things like total_rw_bytes.
> >>>>
> >>>> Not to mention, even we got a fix, it will be another patch.
> >>>>
> >>>> Since the handling of such mismatch is needed to handle older kernel=
s
> >>>> anyway.
> >>>
> >>>   Ok.
> >>>
> >>>
> >>>>>> [FIX]
> >>>>>> Make the super_num_devices check less strict, converting it from a
> >>>>>> hard
> >>>>>> error to a warning, and reset the value to a correct one for the
> >>>>>> current
> >>>>>> or next transaction commitment.
> >>>>>
> >>>>> So that we can leave the part where we identify and report num_devi=
ces
> >>>>> miss-match as it is.
> >>>>
> >>>> I didn't get your point.
> >>>> What do you want to get from this patch?
> >>>>
> >>>> Isn't this already the behavior of this patch?
> >>>
> >>>   Let me clarify - we don't need this patch if we fix the actual bug =
as
> >>> above. IMO.
> >>
> >> Big NO NO.
> >>
> >> The damage is already done, we must be responsible for whatever damage
> >> we caused, especially the damage has already reached disk.
> >>
> >> Just fixing the cause and call it a day is definitely not a
> >> responsible way.
> >>
> >> Especially when the damage is done, you have no way to mount it, just
> >> like the reporter.
> >>
> >> You dare to say the same thing to the end user?
> >
> > You have a btrfs-progs patch to recover from that situation. Right?
> > Plus, I suppose you are sending a kernel patch for the actual bug
> > which is causing this corruption. No?
>
> Not yet. It can be more complex.
> Feel free to try to fix it properly.
>
> >
> > This patch is the reporter side fix. I don't encourage fixing the
> > reporter because a similar corruption might happen for reasons unknown
> > yet. For example, raid1 split-brain? Which is not yet completely
> > analyzed and test-cased yet.
>
> No matter whatever the reason, you still can't deny the fact that, if
> just super num dev mismatches, there is no need to reject the full fs.

As a user .. I expected to be able to mount it with "-o degraded" ..
or/and "-o recovery,ro"

But at the same time .. I don't understand what this "num_devices"
does and/or why it's required...
Or what effects it has on the data-integrity..

It was just very confusing to me because "btrfs check" said everything is f=
ine..

> We have tree-checker for each chunk leave, and rw bytes check already.
> Even the possible bit flip check for num devs.
>
> The super num devs check doesn't make much sense except causing more
> hassles to the end uesr.
>
> The report is just giving us a chance to review if the behavior is
> really helpful.
> To me, NO.
>
> >
> > In my POV.
> >
> > Thanks, Anand
> >
> >
> >
> >>>>> Thanks, Anand
> >>>>>
> >>>>>
> >>>>>> Reported-by: Luca B=C3=A9la Palkovics <luca.bela.palkovics@gmail.c=
om>
> >>>>>> Link:
> >>>>>> https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=3DzqDq_c=
WCOH5TiV46CKmp3igr44okQ@mail.gmail.com/
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>>>> ---
> >>>>>> Changelog:
> >>>>>> v2:
> >>>>>> - Add a proper reason on why this mismatch can happen
> >>>>>>    No code change.
> >>>>>> ---
> >>>>>>   fs/btrfs/volumes.c | 8 ++++----
> >>>>>>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >>>>>> index 74c8024d8f96..d0ba3ff21920 100644
> >>>>>> --- a/fs/btrfs/volumes.c
> >>>>>> +++ b/fs/btrfs/volumes.c
> >>>>>> @@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct
> >>>>>> btrfs_fs_info
> >>>>>> *fs_info)
> >>>>>>        * do another round of validation checks.
> >>>>>>        */
> >>>>>>       if (total_dev !=3D fs_info->fs_devices->total_devices) {
> >>>>>> -        btrfs_err(fs_info,
> >>>>>> -       "super_num_devices %llu mismatch with num_devices %llu fou=
nd
> >>>>>> here",
> >>>>>> +        btrfs_warn(fs_info,
> >>>>>> +       "super_num_devices %llu mismatch with num_devices %llu fou=
nd
> >>>>>> here, will be repaired on next transaction commitment",
> >>>>>>                 btrfs_super_num_devices(fs_info->super_copy),
> >>>>>>                 total_dev);
> >>>>>> -        ret =3D -EINVAL;
> >>>>>> -        goto error;
> >>>>>> +        fs_info->fs_devices->total_devices =3D total_dev;
> >>>>>> +        btrfs_set_super_num_devices(fs_info->super_copy, total_de=
v);
> >>>>>>       }
> >>>>>>       if (btrfs_super_total_bytes(fs_info->super_copy) <
> >>>>>>           fs_info->fs_devices->total_rw_bytes) {
> >>>>>
> >>>
> >
