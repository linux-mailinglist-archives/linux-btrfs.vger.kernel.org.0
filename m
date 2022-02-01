Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F314A61EC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 18:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbiBARHx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 12:07:53 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39182 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiBARHo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 12:07:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1DE3C1F38C;
        Tue,  1 Feb 2022 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643735263;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vD01n2ZyuXGX5pql4CV4i/2kCG3f+j/yOyl4PIyCidU=;
        b=WVRk0i6slZr7YbS4P5bmLDDJZJmudxpGabxHS6qP0UDSuODNC7ZjJ9O0REh4QVCDJRZSlf
        6qcQXZJ0lMeFPdr3jPAS90om9hYzLQ1bnt5UNiV7HwktmyiuACNlMnZh7WLZG0ETxCGrot
        tgrXwPfYq4QHZ08+OPBRXoL6OCcojzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643735263;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vD01n2ZyuXGX5pql4CV4i/2kCG3f+j/yOyl4PIyCidU=;
        b=TA29inx+lB8/8nc+XcaF+aNSx0CPPYbv7oDM3mmKY6oF4n08TJM7OyV+SgjIS9iF8g4VmE
        jbk0mDhAnoWzmqBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 16D44A3B99;
        Tue,  1 Feb 2022 17:07:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1E2F6DA7A9; Tue,  1 Feb 2022 18:06:58 +0100 (CET)
Date:   Tue, 1 Feb 2022 18:06:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: keep device type in the struct btrfs_device
Message-ID: <20220201170658.GV14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1642518245.git.anand.jain@oracle.com>
 <c815946b0b05990230e9342cc50da3d146268b65.1642518245.git.anand.jain@oracle.com>
 <20220126165302.GC14046@twin.jikos.cz>
 <e412efb6-7ea2-cfd2-5c5e-cbe4fdde5c53@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e412efb6-7ea2-cfd2-5c5e-cbe4fdde5c53@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 30, 2022 at 12:24:15AM +0800, Anand Jain wrote:
> On 27/01/2022 00:53, David Sterba wrote:
> > On Tue, Jan 18, 2022 at 11:18:01PM +0800, Anand Jain wrote:
> >> +/*
> >> + * Device class types arranged by their IO latency from low to high.
> >> + */
> >> +enum btrfs_dev_types {
> >> +	BTRFS_DEV_TYPE_MEM = 1,
> >> +	BTRFS_DEV_TYPE_NONROT,
> >> +	BTRFS_DEV_TYPE_ROT,
> >> +	BTRFS_DEV_TYPE_ZONED,
> > 
> > I think this should be separate, in one list define all sensible device
> > types and then add arrays sorted by latency, or other factors.
> >
> > The zoned devices are mostly HDD but ther are also SSD-like using ZNS,
> > so that can't be both under BTRFS_DEV_TYPE_ZONED and behind
> > BTRFS_DEV_TYPE_ROT as if it had worse latency.
> 
> I still do not have a complete idea of its implantation using an array. 
> Do you mean something like as below,
> 
> enum btrfs_dev_types {
> 	::
> };
> 
> struct btrfs_dev_type {
> 	enum btrfs_dev_types dev_type;
> 	int priority_latency;
> };

	enum btrfs_dev_types {
		BTRFS_DEV_TYPE_HDD,
		BTRFS_DEV_TYPE_SSD,
		BTRFS_DEV_TYPE_NVME,
		BTRFS_DEV_TYPE_ZONED_HDD,
		BTRFS_DEV_TYPE_ZONED_ZNS,
	};

	enum btrfs_dev_types btrfs_devices_by_latency[] = {
		BTRFS_DEV_TYPE_NVME,
		BTRFS_DEV_TYPE_SSD,
		BTRFS_DEV_TYPE_ZONED_ZNS,
		BTRFS_DEV_TYPE_HDD,
		BTRFS_DEV_TYPE_ZONED_HDD,
	};

	enum btrfs_dev_types btrfs_devices_by_capacity[] = {
		BTRFS_DEV_TYPE_ZONED_HDD,
		BTRFS_DEV_TYPE_HDD,
		BTRFS_DEV_TYPE_SSD,
		BTRFS_DEV_TYPE_ZONED_ZNS,
		BTRFS_DEV_TYPE_NVME,
	};

Then if the chunk allocator has a selected policy (here by latency and
by capacity), it would use the list as additional sorting criteria.

Optimizing for latency: device 1 (SSD) vs device 2 (NVME), pick NVME
even if device 1 would be otherwise picked due to the capacity criteria
(as we have it now).

> I think we can identify a ZNS and set its relative latency to a value 
> lower (better) than rotational.

The device classes are general I don't mean to measure the latecy
exactly, it's usually typical for the whole class and eg. NVME is
considered better than SSD and SSD better than HDD.

> > I'm not sure how much we should try to guess the device types, the ones
> > you have so far are almost all we can get without peeking too much into
> > the devices/queues internals.
> 
> Agree.
> 
> > Also here's the terminology question if we should still consider
> > rotational device status as the main criteria, because then SSD, NVMe,
> > RAM-backed are all non-rotational but with different latency
> > characteristics.
> 
> Right. The expected performance also depends on the interconnect type
> which is undetectable.
> 
> IMO we shouldn't worry about the non-rational's interconnect types
> (M2/PCIe/NVMe/SATA/SAS) even though they have different performances.

Yeah, that's why I'd stay just with the general storage type, not the
type of connection.

> Because some of these interconnects are compatible with each-other 
> medium might change its interconnect during the lifecycle of the data.
> 
> Then left with are the types of mediums- rotational, non-rotational and
> zoned which, we can identify safely.
> 
> Use-cases plan to mix these types of mediums to achieve the 
> cost-per-byte advantage. As of now, I think our target can be to help these
> kind of planned mixing.
> 
> >> +};
> >> +
> >>   struct btrfs_zoned_device_info;
> >>   
> >>   struct btrfs_device {
> >> @@ -101,9 +111,16 @@ struct btrfs_device {
> >>   
> >>   	/* optimal io width for this device */
> >>   	u32 io_width;
> >> -	/* type and info about this device */
> >> +
> >> +	/* Type and info about this device, on-disk (currently unused) */
> >>   	u64 type;
> >>   
> >> +	/*
> >> +	 * Device type (in memory only) at some point, merge to the on-disk
> >> +	 * member 'type' above.
> >> +	 */
> >> +	enum btrfs_dev_types dev_type;
> > 
> > So at some point this is planned to be user configurable? We should be
> > always able to detect the device type at mount type so I wonder if this
> > needs to be stored on disk.
> 
> I didn't find any planned configs (white papers) discussing the
> advantages of mixing non-rotational drives with different interconnect
> types. If any then, we may have to provide the manual configuration.
> (If the mixing is across the medium types like non-rotational with
> either zoned or HDD, then the users don't have to configure as we can
> optimize the allocation automatically for performance.)
> 
> Also, hot cache device or device grouping (when implemented) need the
> user to configure.
> 
> And so maybe part of in-memory 'dev_type' would be in-sync with on-disk
> 'type' at some point. IMO.

Yeah, the tentative plan for such features is to first make it in-memory
only so we can test it without also defining the permanent on-disk
format. From user perspective if there's a reasonable auto-tuning
behaviour without a need for configuration then it should be
implemented. Once we start adding knobs for various storage types and
what should be stored where, it's a beginning of chaos.
