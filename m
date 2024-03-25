Return-Path: <linux-btrfs+bounces-3562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5517588B006
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 20:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80BE6BE7009
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64C018E3F;
	Mon, 25 Mar 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="louSy/ZE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BBD1B80F;
	Mon, 25 Mar 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394659; cv=none; b=mzyXuvgXrqanqqeLkfHAHc5PyxpLkEq6Q9PmKFLcA8ZUDaV9uZmRGvuITNpL5/+yMExj2S7Wq34Ufk6UAy3e4sk0GGBOD1BjMDdUPysIFVmcZj5VnQJLhzfRBg9ZBrK1lXDuqSkZxT3uoQ/ca21OTIzk1wi8wLCleJ4MMyEYVAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394659; c=relaxed/simple;
	bh=rjiAbqSMklkmsWpuvc7RPKpfXkDhqVKrJE4K0DQjkcI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+sarbGk8PxxR+XcN3EkViZI7d43//O6B/J4McTZ7zkDsJXzATwu7tubMgTP+/vast2b7rRjfIy+Y6f3ChOQkakP8W0+MABgfrOgLRiQ4ko6SfDuzCUNzTmelWEU1WP35RqVVg1jl9zNM+mXfvWnkPSnp1zRCMn8FVQ/yFTxx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=louSy/ZE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e04ac4209eso42309495ad.1;
        Mon, 25 Mar 2024 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711394657; x=1711999457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gcqh7WbCQap+j671Flt7kouSV2578xBHKV1OJxWDSXY=;
        b=louSy/ZEfBOgfxfyNU38se0/OY3fqcDCrlYlpzneLFxwnVEP7MPjGA/ttDWxx1XY9Q
         2vHkah9We94Jgybn0vBw7P+W0OEqc/Dj27bqddWk0di+A78l6wCswVWXt5N3B65DCYZK
         bybUEc+aztKfA92LY2y4stP/G6v1a/LCOyyqbLL6bc73O6EKV/swHdA9z9oXj7T/T3zS
         izgGUyGd0RZnyI0hPKz2ZyKtiWNXgdQL0mfl6p5CNin8MOk3tBi7PKK62vJ2feCGsyC9
         wTbgXPAIRS8pXyD13N32M42cGwfZY4mLBSqOYQyqHx13Rf35sNGSBd1LemHasraztns6
         bpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394657; x=1711999457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gcqh7WbCQap+j671Flt7kouSV2578xBHKV1OJxWDSXY=;
        b=cPCLb9CsOCaQBdpH9lBlptPOnoOTeE91C4UTxpr4m0JHRyXb6H5MvPkkrU54WPIbig
         zRM5hTb05dxvhqKq02HB3ynGER4pvAiHLHcETzsOncperZyh+8c+K2GJO0Lx+urYu3n1
         WeDuAHutCiV4nbYaQufloF6jrY8M3Yhb0jUkJ8cv8RfdrasRmboUycHX6mMqRt3ttPHN
         GJzNoEH1I81wS2mxJL3lFKz+g8BW/CzowufmRlAjQm58QxLHEJH74u6NsoljDsB48eTP
         t6Fdz9dhQRefXRxqZBNO63WVjzK0XelnFno0mhsTpCYOJt/ELY5ToKnNr5WvOajhj3jF
         63oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb31tNorFyqcAdoClGuo0eAy17XNFnTyD89yweIqdP+kBqguKz24lihTB1S4kLuzY6FauyqFcHwDDoQpBujhr5MfTPFD1KHwMqHW2gCvUNgcHFdt2Or1thyFRstZndYLrOTHkpK4FUYIOJcy4ypvDx+Tlfaw3o3PZtLehZX3CFQyIipWM=
X-Gm-Message-State: AOJu0YyGsEJl6+zOMV+WloARpgB8g1yDBY4m8VBQkmKkP8EkUxWhdwQ3
	brntNTDikOve1skvShEGLhTHr5WDf4a3yZtwYOzKlhrGtHnAVilr
X-Google-Smtp-Source: AGHT+IHptWbaGA5R5BVSODc6dJXEPWrSgE+/dHDuKhMePd3v47Y5E93RfCKwiHsOb3ir06gTQz12Sw==
X-Received: by 2002:a17:902:c3d5:b0:1e0:d660:17f with SMTP id j21-20020a170902c3d500b001e0d660017fmr852196plj.61.1711394656928;
        Mon, 25 Mar 2024 12:24:16 -0700 (PDT)
Received: from debian ([2601:641:300:14de:7bed:2ef:bead:18b])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b001e0e2fdfeddsm273377pls.12.2024.03.25.12.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:24:16 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 25 Mar 2024 12:24:02 -0700
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 00/26] DCD: Add support for Dynamic Capacity Devices (DCD)
Message-ID: <ZgHPUggTfSCIx8cI@debian>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>

On Sun, Mar 24, 2024 at 04:18:03PM -0700, ira.weiny@intel.com wrote:
> A git tree of this series can be found here:
> 
> 	https://github.com/weiny2/linux-kernel/tree/dcd-2024-03-24
> 
> Pre-requisite:
> ==============
> 
> 	The locking introduced by Vishal for DAX regions:
> 	https://lore.kernel.org/all/20240124-vv-dax_abi-v7-1-20d16cb8d23d@intel.com/T/#u
> 
> Background
> ==========
> 
> A Dynamic Capacity Device (DCD) (CXL 3.1 sec 9.13.3) is a CXL memory
> device that allows the memory capacity to change dynamically, without
> the need for resetting the device, reconfiguring HDM decoders, or
> reconfiguring software DAX regions.
> 
> One of the biggest use cases for Dynamic Capacity is to allow hosts to
> share memory dynamically within a data center without increasing the
> per-host attached memory.
> 
> The general flow for the addition or removal of memory is to have an
> orchestrator coordinate the use of the memory.  Generally there are 5
> actors in such a system, the Orchestrator, Fabric Manager, the Device
> the host sees, the Host Kernel, and a Host User.
> 
> Typical work flows are shown below.
> 
> Orchestrator      FM         Device       Host Kernel    Host User
> 
>     |             |           |            |              |
>     |-------------- Create region ----------------------->|
>     |             |           |            |              |
>     |             |           |            |<-- Create ---|
>     |             |           |            |    Region    |
>     |<------------- Signal done --------------------------|
>     |             |           |            |              |
>     |-- Add ----->|-- Add --->|--- Add --->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<- Accept -|<- Accept  -|              |
>     |             |   Extent  |   Extent   |              |
>     |             |           |            |<- Create --->|
>     |             |           |            |   DAX dev    |-- Use memory
>     |             |           |            |              |   |
>     |             |           |            |              |   |
>     |             |           |            |<- Release ---| <-+
>     |             |           |            |   DAX dev    |
>     |             |           |            |              |
>     |<------------- Signal done --------------------------|
>     |             |           |            |              |
>     |-- Remove -->|- Release->|- Release ->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<- Release-|<- Release -|              |
>     |             |   Extent  |   Extent   |              |
>     |             |           |            |              |
>     |-- Add ----->|-- Add --->|--- Add --->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<- Accept -|<- Accept  -|              |
>     |             |   Extent  |   Extent   |              |
>     |             |           |            |<- Create ----|
>     |             |           |            |   DAX dev    |-- Use memory
>     |             |           |            |              |   |
>     |             |           |            |<- Release ---| <-+
>     |             |           |            |   DAX dev    |
>     |<------------- Signal done --------------------------|
>     |             |           |            |              |
>     |-- Remove -->|- Release->|- Release ->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<- Release-|<- Release -|              |
>     |             |   Extent  |   Extent   |              |
>     |             |           |            |              |
>     |-- Add ----->|-- Add --->|--- Add --->|              |
>     |  Capacity   |  Extent   |   Extent   |              |
>     |             |           |            |<- Create ----|
>     |             |           |            |   DAX dev    |-- Use memory
>     |             |           |            |              |   |
>     |-- Remove -->|- Release->|- Release ->|              |   |
>     |  Capacity   |  Extent   |   Extent   |              |   |
>     |             |           |            |              |   |
>     |             |           |     (Release Ignored)     |   |
>     |             |           |            |              |   |
>     |             |           |            |<- Release ---| <-+
>     |             |           |            |   DAX dev    |
>     |<------------- Signal done --------------------------|
>     |             |           |            |              |
>     |             |- Release->|- Release ->|              |
>     |             |  Extent   |   Extent   |              |
>     |             |           |            |              |
>     |             |<- Release-|<- Release -|              |
>     |             |   Extent  |   Extent   |              |
>     |             |           |            |<- Destroy ---|
>     |             |           |            |   Region     |
>     |             |           |            |              |
> 
> Previous RFCs of this series[0] resulted in significant architectural
> comments.  Previous versions allowed memory capacity to be accepted by
> the host regardless of the existence of a software region being mapped.
> 
> With this new patch set the order of the create region and DAX device
> creation must be synchronized with the Orchestrator adding/removing
> capacity.  The host kernel will reject an add extent event if the region
> is not created yet.  It will also ignore a release if the DAX device is
> created and referencing an extent.
> 
> Neither of these synchronizations are anticipated to be an issue with
> real applications.
> 
> In order to allow for capacity to be added and removed a new concept of
> a sparse DAX region is introduced.  A sparse DAX region may have 0 or
> more bytes of available space.  The total space depends on the number
> and size of the extents which have been added.
> 
> Initially it is anticipated that users of the memory will carefully
> coordinate the surfacing of additional capacity with the creation of DAX
> devices which use that capacity.  Therefore, the allocation of the
> memory to DAX devices does not allow for specific associations between
> DAX device and extent.  This keeps allocations very similar to existing
> DAX region behavior.
> 
> Great care was taken to greatly simplify extent tracking.  Specifically,
> in comparison to previous versions of the patch set, all extent tracking
> xarrays have been eliminated from the code.  In addition, most of the
> extra software objects and associated referenced counts have been
> eliminated.
> 
> In this version, extents are tracked purely as sub-devices of the
> region.  This ensures that the region destruction cleans up all extent
> allocations properly.  Device managed callbacks are wired to ensure any
> additional data required for DAX device references are handled
> correctly.
> 
> Due to these major changes I'm setting this new series to V1.
> 
> In summary the major functionality of this series includes:
> 
> - Getting the dynamic capacity (DC) configuration information from cxl
>   devices
> 
> - Configuring the DC regions reported by hardware
> 
> - Enhancing the CXL and DAX regions for dynamic capacity support
> 	a. Maintain a logical separation between hardware extents and
> 	   software managed region extents.  This provides an
> 	   abstraction between the layers and should allow for
> 	   interleaving in the future
> 
> - Get hardware extent lists for endpoint decoders upon
>   region creation.
> 
> - Adjust extent/region memory available on the following events.
>         a. Add capacity Events
> 	b. Release capacity events
> 
> - Host response for add capacity
> 	a. do not accept the extent if:
> 		If the region does not exist
> 		or an error occurs realizing the extent
> 	B. If the region does exist
> 		realize a DAX region extent with 1:1 mapping (no
> 		interleave yet)
> 
> - Host response for remove capacity
> 	a. If no DAX devices reference the extent release the extent
> 	b. If a reference does exist, ignore the request.
> 	   (Require FM to issue release again.)
> 
> - Modify DAX device creation/resize to account for extents within a
>   sparse DAX region
> 
> - Trace Dynamic Capacity events for debugging
> 
> - Add cxl-test infrastructure to allow for faster unit testing
>   (See new ndctl branch for cxl-dcd.sh test[1])
> 
> Fan Ni's latest v5 of Qemu DCD was used for testing.[2]
> 
> Remaining work:
> 
> 	1) Integrate the QoS work from Dave Jiang
> 	2) Interleave support
> 
> Possible additional work depending on requirements:
> 
> 	1) Allow mapping to specific extents (perhaps based on
> 	   label/tag)
> 	2) Release extents when DAX devices are released if a release
> 	   was previously seen from the device
> 	3) Accept a new extent which extends (but overlaps) an existing
> 	   extent(s)
> 
> [0] RFC v2: https://lore.kernel.org/r/20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com
> [1] https://github.com/weiny2/ndctl/tree/dcd-region2-2024-03-22
> [2] https://lore.kernel.org/all/20240304194331.1586191-1-nifan.cxl@gmail.com/
> 
> ---
> Changes for v1:
> - iweiny: Largely new series
> - iweiny: Remove review tags due to the series being a major rework
> - iweiny: Fix authorship for Navneet patches
> - iweiny: Remove extent xarrays
> - iweiny: Remove kreferences, replace with 1 use count protected under dax_rwsem
> - iweiny: Mark all sysfs entries for the 6.10 June 2024 kernel
> - iweiny: Remove gotos
> - iweiny: Fix 0day issues
> - Jonathan Cameron: address comments
> - Navneet Singh: address comments
> - Dan Williams: address comments
> - Dave Jiang: address comments
> - Fan Ni: address comments
> - Jørgen Hansen: address comments
> - Link to RFC v2: https://lore.kernel.org/r/20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com
> 

Hi Ira,
Have not got a chance to check the code yet, but I noticed one thing
when testing with my DCD emulation code.
Currently, if we do partial release, it seems the whole extent will be
removed. Is it designed intentionally?

Fan

> ---
> Ira Weiny (12):
>       cxl/core: Simplify cxl_dpa_set_mode()
>       cxl/events: Factor out event msgnum configuration
>       cxl/pci: Delay event buffer allocation
>       cxl/pci: Factor out interrupt policy check
>       range: Add range_overlaps()
>       dax/bus: Factor out dev dax resize logic
>       dax: Document dax dev range tuple
>       dax/region: Prevent range mapping allocation on sparse regions
>       dax/region: Support DAX device creation on sparse DAX regions
>       tools/testing/cxl: Make event logs dynamic
>       tools/testing/cxl: Add DC Regions to mock mem data
>       tools/testing/cxl: Add Dynamic Capacity events
> 
> Navneet Singh (14):
>       cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
>       cxl/core: Separate region mode from decoder mode
>       cxl/mem: Read dynamic capacity configuration from the device
>       cxl/region: Add dynamic capacity decoder and region modes
>       cxl/port: Add Dynamic Capacity mode support to endpoint decoders
>       cxl/port: Add dynamic capacity size support to endpoint decoders
>       cxl/mem: Expose device dynamic capacity capabilities
>       cxl/region: Add Dynamic Capacity CXL region support
>       cxl/mem: Configure dynamic capacity interrupts
>       cxl/region: Read existing extents on region creation
>       cxl/extent: Realize extent devices
>       dax/region: Create extent resources on DAX region driver load
>       cxl/mem: Handle DCD add & release capacity events.
>       cxl/mem: Trace Dynamic capacity Event Record
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |  60 ++-
>  drivers/cxl/core/Makefile               |   1 +
>  drivers/cxl/core/core.h                 |  10 +
>  drivers/cxl/core/extent.c               | 145 +++++
>  drivers/cxl/core/hdm.c                  | 254 +++++++--
>  drivers/cxl/core/mbox.c                 | 591 ++++++++++++++++++++-
>  drivers/cxl/core/memdev.c               |  76 +++
>  drivers/cxl/core/port.c                 |  19 +
>  drivers/cxl/core/region.c               | 334 +++++++++++-
>  drivers/cxl/core/trace.h                |  65 +++
>  drivers/cxl/cxl.h                       | 127 ++++-
>  drivers/cxl/cxlmem.h                    | 114 ++++
>  drivers/cxl/mem.c                       |  45 ++
>  drivers/cxl/pci.c                       | 122 +++--
>  drivers/dax/bus.c                       | 353 +++++++++---
>  drivers/dax/bus.h                       |   4 +-
>  drivers/dax/cxl.c                       | 127 ++++-
>  drivers/dax/dax-private.h               |  40 +-
>  drivers/dax/hmem/hmem.c                 |   2 +-
>  drivers/dax/pmem.c                      |   2 +-
>  fs/btrfs/ordered-data.c                 |  10 +-
>  include/linux/cxl-event.h               |  31 ++
>  include/linux/range.h                   |   7 +
>  tools/testing/cxl/Kbuild                |   1 +
>  tools/testing/cxl/test/mem.c            | 914 ++++++++++++++++++++++++++++----
>  25 files changed, 3152 insertions(+), 302 deletions(-)
> ---
> base-commit: dff54316795991e88a453a095a9322718a34034a
> change-id: 20230604-dcd-type2-upstream-0cd15f6216fd
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 

