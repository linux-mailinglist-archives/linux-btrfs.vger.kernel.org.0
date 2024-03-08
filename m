Return-Path: <linux-btrfs+bounces-3139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C73876CA5
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 23:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA691F22212
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 22:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E825FBBB;
	Fri,  8 Mar 2024 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d.umn.edu header.i=@d.umn.edu header.b="WhHSwTvP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mta-p8.oit.umn.edu (mta-p8.oit.umn.edu [134.84.196.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF11E515
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.84.196.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935527; cv=none; b=Cb1uLPvpXurrpoMzzrnVV8m2hKRSRBA5XzHZRQYGKaVaWp+WdsOgPJZJojtbYvQBxn9OD+lh4Eyon4+egAB8jwnPT5jNr8JpyxfyWLGcmrUqI7QpLQ9K8+/doEujIj6aHaoS2E10xmu7wyrGwvRWtTcLu3FvMLeI7Wc7Cdf/ZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935527; c=relaxed/simple;
	bh=phVm4AWRTkyFq9RxrljEsxc3XJ5O3i3LVHkMAhe4D8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTyybujqBOHta+mELEX6v/NmuWcIAIV40cE7Oo1o0Ezyl9qn5tDbtKKCunuB3ofoe7ETECke5LUs4wQRAlkuD8VjJuGJsRmwTcHMrv7ozt+E/vydev1GPr5+9K6hhXo0fBxKpgHvI8o69eKSEC1aE2UsiYJLhkvcK1GPZHNDr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d.umn.edu; spf=pass smtp.mailfrom=d.umn.edu; dkim=pass (2048-bit key) header.d=d.umn.edu header.i=@d.umn.edu header.b=WhHSwTvP; arc=none smtp.client-ip=134.84.196.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d.umn.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d.umn.edu
Received: from localhost (unknown [127.0.0.1])
	by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4Ts0SG5GLbz9vhV9
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 21:59:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
	by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DQRsK51-iJ-2 for <linux-btrfs@vger.kernel.org>;
	Fri,  8 Mar 2024 15:59:10 -0600 (CST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4Ts0SG3RBcz9vhTh
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 15:59:10 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4Ts0SG3RBcz9vhTh
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4Ts0SG3RBcz9vhTh
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ce632b2adfso2027972a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Mar 2024 13:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google; t=1709935149; x=1710539949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phVm4AWRTkyFq9RxrljEsxc3XJ5O3i3LVHkMAhe4D8Q=;
        b=WhHSwTvPXbBZALl6zgyZiNWt/nXg+9Ht0XcUzE66GHm5MjXwwnS8hz832mviW/ccz0
         lRVwhoYSSbXm+am7JY4ERWs4SFxfo70HJe3RYNJIXDpQkpw+Pg1QYhVrXi9sF1U7Mh7i
         SX4aYhdHcqMQcGpu7cMc5KcP51GmZeiiwmYAWuAHjF2gSR9JKYSrSaIIY73tShSY+Qx1
         wup/qbWmEJD38iRpEF2euLVTk8jn28Q/txQYugtJREUjuSkrtObWnB/S4SadVGDNBzVF
         ryX/74/MdCHZ+9dk8xe/trda9w7dAcz76vqE6D1IDtksz7u2oNXlGtvNR2FeDv5OVGry
         /V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709935149; x=1710539949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phVm4AWRTkyFq9RxrljEsxc3XJ5O3i3LVHkMAhe4D8Q=;
        b=FtaXDONf3L7MQ/Twn5aSwnTecIAcDwmX40lfD7AWAK7P6WiSq8UYkHXyLFp2c31PhP
         1y+7HOfb25BY3wzHjlL6/dMiqFwlDdXofmfjLH6L/9s5CgodNqsV7E/CanjYMLR3aHKW
         2tcBZaErJIdeKcf2nKbzZ1lo5bETOkm8kl2KuMEUbIjUuIVyw4Bk54AIXC1PkQL4WYtI
         Vzg35AHpXVB76/vAO470XQH0HL0sFG027bL4Tb2iYPMBJbJjsPJjihXBYAOxcjoTT8BP
         A6uK6ZY2ofGrCYCn/uw1MekYFKj4Cs+X7KoH6T/f2Vd1p1+kMmu7F2A4NVoz4QFHuYPf
         +Dkg==
X-Gm-Message-State: AOJu0YyWo5Wz4BMf9UGPEA1uVDctyiAM87k8BhFrj8jS5knp5WetKhd9
	Vebe5fcmdAnhk36Y13MkarbChOhPits/ux+1teqtFHFdQ6uSRVqdCjqTe2R5W9GDRnNrTPqNvQp
	Cv2Q+FUuleSX8wyKpW8HHOUJVBOHxt0x/sfU/cA6N5P6xyQ5mtTJ20E0WPGpII1GisGXF0Er/xW
	d2PsBgf8NKeJbNIgO0A9YFaBKYgnxgfa3yRvVenw==
X-Received: by 2002:a05:6a21:33a6:b0:1a0:df64:26c with SMTP id yy38-20020a056a2133a600b001a0df64026cmr395117pzb.16.1709935149738;
        Fri, 08 Mar 2024 13:59:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG18JwN4PWpxfaTWaKJ1ZjJVSsFtswiO2+mRF4zmXA3InOcm/rHBhNb2S8eqOUuPfeUmBSWdhpc5jswxOI13q8=
X-Received: by 2002:a05:6a21:33a6:b0:1a0:df64:26c with SMTP id
 yy38-20020a056a2133a600b001a0df64026cmr395108pzb.16.1709935149475; Fri, 08
 Mar 2024 13:59:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
 <CA+H1V9x-pFAM-YQ1ncAqZE4e7j6R2xQXX6Ah9v1tMNf8CrW+yw@mail.gmail.com>
 <CAOLfK3We92ZBrvyvSDky9jrQwJNONeOE9qoaewbFCr02H8PuTw@mail.gmail.com> <CA+H1V9xjufQpsZHeMNmKNrV0BfuUsJ5G=x_-BEcRw7eNFhYPAw@mail.gmail.com>
In-Reply-To: <CA+H1V9xjufQpsZHeMNmKNrV0BfuUsJ5G=x_-BEcRw7eNFhYPAw@mail.gmail.com>
From: Matt Zagrabelny <mzagrabe@d.umn.edu>
Date: Fri, 8 Mar 2024 15:58:57 -0600
Message-ID: <CAOLfK3UEOMN-O9-u6j22CJ0jpRZUwB7R_x-zEH6-FXdgmqB7Lg@mail.gmail.com>
Subject: Re: raid1 root device with efi
To: Matthew Warren <matthewwarren101010@gmail.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 3:54=E2=80=AFPM Matthew Warren
<matthewwarren101010@gmail.com> wrote:
>
> On Fri, Mar 8, 2024 at 4:48=E2=80=AFPM Matt Zagrabelny <mzagrabe@d.umn.ed=
u> wrote:
> >
> > Hi Qu and Matthew,
> >
> > On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Matthew Warren
> > <matthewwarren101010@gmail.com> wrote:
> > >
> > > On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Matt Zagrabelny <mzagrabe@d.um=
n.edu> wrote:
> > > >
> > > > Greetings,
> > > >
> > > > I've read some conflicting info online about the best way to have a
> > > > raid1 btrfs root device.
> > > >
> > > > I've got two disks, with identical partitioning and I tried the
> > > > following scenario (call it scenario 1):
> > > >
> > > > partition 1: EFI
> > > > partition 2: btrfs RAID1 (/)
> > > >
> > > > There are some docs that claim that the above is possible...
> > >
> > > This is definitely possible. I use it on both my server and desktop w=
ith GRUB.
> >
> > Are there any docs you follow for this setup?
> >
> > Thanks for the info!
> >
> > -m
>
> The main important thing is that mdadm has several metadata versions.
> Versions 0.9 and 1.0 store the metadata at the end of the partition
> which allows UEFI to think the filesystem is EFI rather than mdadm
> raid.
> https://raid.wiki.kernel.org/index.php/RAID_superblock_formats#Sub-versio=
ns_of_the_version-1_superblock
>
> I followed the arch wiki for setting it up, so here's what I followed.
> https://wiki.archlinux.org/title/EFI_system_partition#ESP_on_software_RAI=
D1

Thanks for the hints. Hopefully there aren't any more unexpected issues.

Cheers!

-m

