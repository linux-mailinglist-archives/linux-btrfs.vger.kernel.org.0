Return-Path: <linux-btrfs+bounces-12935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFE4A8373E
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 05:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8318019E5619
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 03:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF21D1EFFA4;
	Thu, 10 Apr 2025 03:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnG7ufni"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE454C8F
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Apr 2025 03:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744256199; cv=none; b=aHBgWP8VTWsXXzMxVdgpBNEFr8U1UiY8G2DL+SqBQuVEAr/B/vkEdRNoDOC9l9d6MIjHOt2W7POaUNIKEkF3sUCJLvarHs3tR+q1DCI95VFUKKQjRC0pAgkov7oJV3goxpRNfcUkN7P1J8JMcNkQQWFNUKHtQEmXfYM57jUKym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744256199; c=relaxed/simple;
	bh=3EVMqDZhtEMUyyHuO/YspdYw8Up2rJJJHY9Xn5ApRH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjUBoVwU3S+AKmOEF6k78Gd/POGbiKr3vGMlyH0FeLItFVr9wpf49xpO2oM7Ry2LTUD/g+8OIXQa6PliiMqwcAt+ffonYvOt1+r7lPaP5Wyh6xD90Q1urIVhpIWP18X0HS8B+3OJkpv+grkhPzDCyTieyLcVdmXuzXvp9RIgpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnG7ufni; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-477296dce76so2834851cf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Apr 2025 20:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744256196; x=1744860996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3wsU871xSidA/UXdCTwYo3AWy9lMmfawIe+6qR4hqiQ=;
        b=AnG7ufni1xf/kr8nr2zeO8VEjAVXXpW/qcii8IAwMHqPRQ6fO+rs2DPCElvpAdciz+
         G9TXX149jwr6znUIJNljH7m34rpWh83fkoqJOV3AFwp2CBGysHKrzMDR3ex78hfhLg30
         DEHucM7NHB+4imX5LPTW7GJyjy4D6QDuNTEJaFRIwbS893VXfGessCYx12OFqyBeVWr4
         ZSY5FzrE2oVnxbl97w2uiqe8RDCltkMAUsOlQxVnPvCkXHB2DUrf15H24FjFRKpmO41D
         T0ibCH9O4LosOdx0r8WJ6OiO9D5RkxkwRqqCSX8c1S8mRa/dMH/uv8DaWuCADU4f5unh
         HrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744256196; x=1744860996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wsU871xSidA/UXdCTwYo3AWy9lMmfawIe+6qR4hqiQ=;
        b=XB8ZIInMUlpfAQToYI6ifLm1Ky5rDAc6vA6m+GmldWRQkSLieY/5+E3L7A8KyzZSp+
         S/9AcrMAFKcp22lnKV4ds+gu4NuRUsZzUVzJ5NegoubyzEDWEmPfKe3cMg2VUHXAL5/D
         j+wndS9aMnWSVaoEPzqLYaMoaeYQ1SHa/Rnp9Yl86xeMhjPHl4oyFWbKw29mFWNcESwX
         I586sZEgRzcna1lEPrMLrxgSotyu7InLLhXF8guBDg3JPG+LY2+tK+AzBC8hElVECtr5
         ZJeKGG7X2n0qqEESzq7/UkanwIiqVUU2TYaBgU/BmIHqDCU2Ueshl4EF+jeyddfdwQdN
         bD+Q==
X-Gm-Message-State: AOJu0YzBvi2UZ+jNXapD/yPmhSX7KLNu7BY3w+1jHNloBBjKS4gXOlt/
	kSN/xANZY5GIR4qjvZHbCuq9wuRPyj42QeHlQIROf3NVE4ObuKrSPOkqAq73R461yTlzVO/a4A9
	TyxSSYjvOQ4EGy/Zu4WGU0oTMqEM=
X-Gm-Gg: ASbGncub2kLUWkDVtIuXq1KWnuJmM4Qdv2kvfHh+MXO+mWXOUBbQSabNEPFrUGSuw1S
	h1TdjGKwyppgd25DOiWY2Af0iQWBTib5RVKYUV0FX7oviZ7f6LKT7UPyRRG9rDi+ATYGgcIzwV7
	ZN7eFsMbMHy4iVTJqjqz5loU6nK8j8vUbmfbjAk++AcryEqr8JC2vA0GI=
X-Google-Smtp-Source: AGHT+IG91T2jHpsrjAMsrQq6F5M/3W3F0xy53GXKF7+hIGeg+xafo94A7VoTD48mLmVidYioh1RXl4378NVDf/bIerM=
X-Received: by 2002:ac8:7d82:0:b0:476:7c7b:5dce with SMTP id
 d75a77b69052e-4796cba0be3mr17472421cf.9.1744256196181; Wed, 09 Apr 2025
 20:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1735748715.git.anand.jain@oracle.com> <0878345c55203627eb5dcf0e29d5101c29f49c6b.1735748715.git.anand.jain@oracle.com>
 <CAMthOuMQnDta-4Uo98CNsvL0Xkp77K8TDfEvirUnBjkJqVwptQ@mail.gmail.com>
In-Reply-To: <CAMthOuMQnDta-4Uo98CNsvL0Xkp77K8TDfEvirUnBjkJqVwptQ@mail.gmail.com>
From: Kai Krakow <hurikhan77+btrfs@gmail.com>
Date: Thu, 10 Apr 2025 05:36:10 +0200
X-Gm-Features: ATxdqUEtcZnwRZkmdu51OOxqjIcfGVLrD-OQJfXZE8b7krWMLjH5V-g8XhURvhQ
Message-ID: <CAMthOuOyM5V0yjrqPnhPDrEydCpoHH_d1D9u2hYMQBHkF+Tu3g@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] btrfs: enable RAID1 balancing configuration via
 modprobe parameter
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, Naohiro.Aota@wdc.com, 
	wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Content-Type: text/plain; charset="UTF-8"

Hello!

Am Mi., 9. Apr. 2025 um 18:59 Uhr schrieb Kai Krakow
<hurikhan77+btrfs@gmail.com>:
>
> Hi Anand!
>
> Am Mi., 1. Jan. 2025 um 19:10 Uhr schrieb Anand Jain <anand.jain@oracle.com>:
> >
> > This update allows configuring the `raid1-balancing` methods using a
> > modprobe parameter when experimental mode CONFIG_BTRFS_EXPERIMENTAL
> > is enabled.
> >
> > Examples:
> >
> > - Set the RAID1 balancing method to round-robin with a custom
> > `min_contiguous_read` of 4k:
> >   $ modprobe btrfs raid1-balancing=round-robin:4096
> >
> > - Set the round-robin balancing method with the default
> > `min_contiguous_read`:
> >   $ modprobe btrfs raid1-balancing=round-robin
> >
> > - Set the `devid` balancing method, defaulting to the latest
> > device:
> >   $ modprobe btrfs raid1-balancing=devid
> >
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > ---
> >  fs/btrfs/super.c   |  5 +++++
> >  fs/btrfs/sysfs.c   | 30 +++++++++++++++++++++++++++++-
> >  fs/btrfs/sysfs.h   |  5 +++++
> >  fs/btrfs/volumes.c | 14 +++++++++++++-
> >  4 files changed, 52 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index fb6a009c72ae..58190989a29d 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -2538,6 +2538,11 @@ static const struct init_sequence mod_init_seq[] = {
> >         }, {
> >                 .init_func = extent_map_init,
> >                 .exit_func = extent_map_exit,
> > +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> > +       }, {
> > +               .init_func = btrfs_raid1_balancing_init,
> > +               .exit_func = NULL,
> > +#endif
> >         }, {
> >                 .init_func = ordered_data_init,
> >                 .exit_func = ordered_data_exit,
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index eb23f29995e4..ac1a32af2442 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -1313,7 +1313,21 @@ static const char *btrfs_read_policy_name[] = {
> >  #endif
> >  };
> >
> > -static int btrfs_read_policy_to_enum(const char *str, s64 *value)
> > +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> > +/* Global module configuration parameters */
> > +static char *raid1_balancing;
> > +char *btrfs_get_raid1_balancing(void)
> > +{
> > +       return raid1_balancing;
> > +}
> > +
> > +/* Set perm 0, disable sys/module/btrfs/parameter/raid1_balancing interface */
> > +module_param(raid1_balancing, charp, 0);
> > +MODULE_PARM_DESC(raid1_balancing,
> > +"Global read policy; pid (default), round-robin[:min_contiguous_read], devid[[:devid]|[:latest-gen]|[:oldest-gen]]");
>
> I don't see where "[:latest-gen]|[:oldest-gen]" would be used in the code.

I just realized this has been fixed in the final merged patchset.
Sorry for the noise.

> > +#endif
> > +
> > +int btrfs_read_policy_to_enum(const char *str, s64 *value)
> >  {
> >         char param[32] = {'\0'};
> >         char *__maybe_unused value_str;
> > @@ -1336,6 +1350,20 @@ static int btrfs_read_policy_to_enum(const char *str, s64 *value)
> >         return sysfs_match_string(btrfs_read_policy_name, param);
> >  }
> >
> > +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> > +int __init btrfs_raid1_balancing_init(void)
> > +{
> > +       s64 value;
> > +
> > +       if (btrfs_read_policy_to_enum(raid1_balancing, &value) == -EINVAL) {
> > +               btrfs_err(NULL, "Invalid raid1_balancing %s", raid1_balancing);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +#endif
> > +
> >  static ssize_t btrfs_read_policy_show(struct kobject *kobj,
> >                                       struct kobj_attribute *a, char *buf)
> >  {
> > diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
> > index e6a284c59809..e97d383b9ffc 100644
> > --- a/fs/btrfs/sysfs.h
> > +++ b/fs/btrfs/sysfs.h
> > @@ -47,5 +47,10 @@ void btrfs_sysfs_del_qgroups(struct btrfs_fs_info *fs_info);
> >  int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info);
> >  void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
> >                                 struct btrfs_qgroup *qgroup);
> > +int btrfs_read_policy_to_enum(const char *str, s64 *value);
> > +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> > +int __init btrfs_raid1_balancing_init(void);
> > +char *btrfs_get_raid1_balancing(void);
> > +#endif
> >
> >  #endif
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index e8cccfad6ad3..e5e9b33837b8 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -1299,6 +1299,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
> >         struct btrfs_device *device;
> >         struct btrfs_device *latest_dev = NULL;
> >         struct btrfs_device *tmp_device;
> > +       s64 __maybe_unused value = 0;
> >         int ret = 0;
> >
> >         /* Initialize the in-memory record of filesystem read count */
> > @@ -1333,10 +1334,21 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
> >         fs_devices->latest_dev = latest_dev;
> >         fs_devices->total_rw_bytes = 0;
> >         fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
> > -       fs_devices->read_policy = BTRFS_READ_POLICY_PID;
> >  #ifdef CONFIG_BTRFS_EXPERIMENTAL
> >         fs_devices->rr_min_contiguous_read = BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ;
> >         fs_devices->read_devid = latest_dev->devid;
> > +       fs_devices->read_policy =
> > +               btrfs_read_policy_to_enum(btrfs_get_raid1_balancing(), &value);
> > +       if (fs_devices->read_policy == BTRFS_READ_POLICY_RR)
> > +               fs_devices->fs_stats = true;
> > +       if (value) {
> > +               if (fs_devices->read_policy == BTRFS_READ_POLICY_RR)
> > +                       fs_devices->rr_min_contiguous_read = value;
> > +               if (fs_devices->read_policy == BTRFS_READ_POLICY_DEVID)
> > +                       fs_devices->read_devid = value;
> > +       }
> > +#else
> > +       fs_devices->read_policy = BTRFS_READ_POLICY_PID;
> >  #endif
> >
> >         return 0;
> > --
> > 2.47.0
>
> Thanks
> Kai

