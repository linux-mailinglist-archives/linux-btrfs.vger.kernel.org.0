Return-Path: <linux-btrfs+bounces-9396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 060859C22E9
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 18:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8771F225C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 17:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A131F4FB6;
	Fri,  8 Nov 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIPCquhp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316415B0F7;
	Fri,  8 Nov 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086854; cv=none; b=FeGd0cZ+LNzBqMlQjq2SEiINvxrg7yRbwgT4WmdMxoNNx1P+bUESSDBnk04u3i+UJj/Rlli19preQaKSMokl3Wd7FiORJYf9wT3Awq7oiCJQrMpY8einJfg+CRn/aI7M0geiN61dJLMIpPSI4RwWKe6XhWqHuo172G6Y8aDRpnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086854; c=relaxed/simple;
	bh=f4PJaVljdIJ/oBBjOmHGAG8o+kWjkBTU3psAdpIWRAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BorDpuAy3aTKZoOKGId8C1YiYieI+tjVOEOdSr8Nm8bx1otEpuX+tHcY34Y8YGMOamGAT7e+W6KRy+E4yTklAo6fXCU42ap+UiKOGWqEG+qd+G7JaIziqSZr2/MQr84vcjn0j0tSUVBBVw4aiVvpqD2bzpKJelbtTZi84dNEfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIPCquhp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731086852; x=1762622852;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f4PJaVljdIJ/oBBjOmHGAG8o+kWjkBTU3psAdpIWRAE=;
  b=IIPCquhps4SSIIQDJoGhZPU2ksv2JyNOP+HAody799j5xSDG5foLE6LT
   YjKlTUYwEXJOuvWmcP8dqKKWOkonuB995EAeQ1wC56xechYhY263+bw6+
   997VHVcGSVKzWt2Bpcsy1zGaZcLIkykjPkqeKt7P6MKiUKMBC0FXFX1G4
   OEelosQPEVXeoWYbHE7z5NGbxY7mvsv0gAjL3TqTB687HD+6LkotjuQAE
   BsScM2DnPA3gRuv+lKideSbM2JZMds8U61YUlphw5Pp5lbUygQ6+2s3UT
   20Kl1iJ+G+Le8x/6uM1tAZe7c+0CdqOygUbtdFsYabiqpJi38f9CKm/MB
   g==;
X-CSE-ConnectionGUID: BMxLxN3JTmW2sypEp+MSjw==
X-CSE-MsgGUID: ZV4WMbujStaqywsOSW6g5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30937563"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30937563"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 09:27:30 -0800
X-CSE-ConnectionGUID: haoDRfOqRGaNcx230Kdacg==
X-CSE-MsgGUID: 19cBg4iPRZqh0P8i3L1N0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="123176009"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.110.245]) ([10.125.110.245])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 09:27:29 -0800
Message-ID: <d02f217d-ae4f-476c-a20b-2b449cff73c0@intel.com>
Date: Fri, 8 Nov 2024 10:27:28 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/27] DCD: Add support for Dynamic Capacity Devices
 (DCD)
To: Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Johannes Thumshirn
 <johannes.thumshirn@wdc.com>, Robert Moore <robert.moore@intel.com>,
 Len Brown <lenb@kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, Li Ming <ming4.li@intel.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
References: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/24 1:58 PM, Ira Weiny wrote:
> A git tree of this series can be found here:
> 
> 	https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-11-07
> 
> This is a quick spin with minor clean ups Dave was going to apply as
> well as a couple of clean ups I had slated for after V4 landed.

Top 6 patches (for DCD preparation) applied to cxl/next for 6.13 merge window. 

> 
> Series info
> ===========
> 
> This series has 4 parts:
> 
> Patch 1: Add core range_overlaps() function
> Patch 2-6: CXL clean up/prelim patches
> Patch 7-25: Core DCD support
> Patch 26-27: cxl_test support
> 
> Patches 1-6 have received a lot of review and can be applied to cxl-next
> straight away.  While 7-27 may need to wait for Dan review.
> 
> Background
> ==========
> 
> A Dynamic Capacity Device (DCD) (CXL 3.1 sec 9.13.3) is a CXL memory
> device that allows memory capacity within a region to change
> dynamically without the need for resetting the device, reconfiguring
> HDM decoders, or reconfiguring software DAX regions.
> 
> One of the biggest use cases for Dynamic Capacity is to allow hosts to
> share memory dynamically within a data center without increasing the
> per-host attached memory.
> 
> The general flow for the addition or removal of memory is to have an
> orchestrator coordinate the use of the memory.  Generally there are 5
> actors in such a system, the Orchestrator, Fabric Manager, the Logical
> device, the Host Kernel, and a Host User.
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
> Implementation
> ==============
> 
> The series still requires the creation of regions and DAX devices to be
> closely synchronized with the Orchestrator and Fabric Manager.  The host
> kernel will reject extents if a region is not yet created.  It also
> ignores extent release if memory is in use (DAX device created).  These
> synchronizations are not anticipated to be an issue with real
> applications.
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
> To keep the DAX memory allocation aligned with the existing DAX devices
> which do not have tags extents are not allowed to have tags.  Future
> support for tags is planned.
> 
> Great care was taken to keep the extent tracking simple.  Some xarray's
> needed to be added but extra software objects were kept to a minimum.
> 
> Region extents continue to be tracked as sub-devices of the DAX region.
> This ensures that region destruction cleans up all extent allocations
> properly.
> 
> Some review tags were kept if a patch did not change.
> 
> The major functionality of this series includes:
> 
> - Getting the dynamic capacity (DC) configuration information from cxl
>   devices
> 
> - Configuring the DC partitions reported by hardware
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
> 	b. If the region does exist
> 		realize a DAX region extent with 1:1 mapping (no
> 		interleave yet)
> 	c. Support the event more bit by processing a list of extents
> 	   marked with the more bit together before setting up a
> 	   response.
> 
> - Host response for remove capacity
> 	a. If no DAX device references the extent; release the extent
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
> - Only support 0 value extent tags
> 
> Fan Ni's upstream of Qemu DCD was used for testing.
> 
> Remaining work:
> 
> 	1) Allow mapping to specific extents (perhaps based on
> 	   label/tag)
> 	   1a) devise region size reporting based on tags
> 	2) Interleave support
> 
> Possible additional work depending on requirements:
> 
> 	1) Accept a new extent which extends (but overlaps) an existing
> 	   extent(s)
> 	2) Release extents when DAX devices are released if a release
> 	   was previously seen from the device
> 	3) Rework DAX device interfaces, memfd has been explored a bit
> 
> [1] https://github.com/weiny2/ndctl/tree/dcd-region2-2024-10-01
> 
> ---
> Changes in v7:
> - Pick up review tags
> - Ming: Fix setting the more flag
> - Link to v6: https://patch.msgid.link/20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com
> 
> ---
> Ira Weiny (13):
>       range: Add range_overlaps()
>       ACPI/CDAT: Add CDAT/DSMAS shared and read only flag values
>       dax: Document struct dev_dax_range
>       cxl/pci: Delay event buffer allocation
>       cxl/hdm: Use guard() in cxl_dpa_set_mode()
>       cxl/region: Refactor common create region code
>       cxl/cdat: Gather DSMAS data for DCD regions
>       cxl/events: Split event msgnum configuration from irq setup
>       cxl/pci: Factor out interrupt policy check
>       cxl/core: Return endpoint decoder information from region search
>       dax/bus: Factor out dev dax resize logic
>       tools/testing/cxl: Make event logs dynamic
>       tools/testing/cxl: Add DC Regions to mock mem data
> 
> Navneet Singh (14):
>       cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
>       cxl/mem: Read dynamic capacity configuration from the device
>       cxl/core: Separate region mode from decoder mode
>       cxl/region: Add dynamic capacity decoder and region modes
>       cxl/hdm: Add dynamic capacity size support to endpoint decoders
>       cxl/mem: Expose DCD partition capabilities in sysfs
>       cxl/port: Add endpoint decoder DC mode support to sysfs
>       cxl/region: Add sparse DAX region support
>       cxl/mem: Configure dynamic capacity interrupts
>       cxl/extent: Process DCD events and realize region extents
>       cxl/region/extent: Expose region extent information in sysfs
>       dax/region: Create resources on sparse DAX regions
>       cxl/region: Read existing extents on region creation
>       cxl/mem: Trace Dynamic capacity Event Record
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |  125 +++-
>  drivers/cxl/core/Makefile               |    2 +-
>  drivers/cxl/core/cdat.c                 |   45 +-
>  drivers/cxl/core/core.h                 |   34 +-
>  drivers/cxl/core/extent.c               |  502 +++++++++++++++
>  drivers/cxl/core/hdm.c                  |  231 ++++++-
>  drivers/cxl/core/mbox.c                 |  610 +++++++++++++++++-
>  drivers/cxl/core/memdev.c               |  128 +++-
>  drivers/cxl/core/port.c                 |   19 +-
>  drivers/cxl/core/region.c               |  185 ++++--
>  drivers/cxl/core/trace.h                |   65 ++
>  drivers/cxl/cxl.h                       |  122 +++-
>  drivers/cxl/cxlmem.h                    |  132 +++-
>  drivers/cxl/pci.c                       |  122 +++-
>  drivers/dax/bus.c                       |  356 +++++++++--
>  drivers/dax/bus.h                       |    4 +-
>  drivers/dax/cxl.c                       |   71 ++-
>  drivers/dax/dax-private.h               |   66 +-
>  drivers/dax/hmem/hmem.c                 |    2 +-
>  drivers/dax/pmem.c                      |    2 +-
>  fs/btrfs/ordered-data.c                 |   10 +-
>  include/acpi/actbl1.h                   |    2 +
>  include/cxl/event.h                     |   32 +
>  include/linux/ioport.h                  |    3 +
>  include/linux/range.h                   |    8 +
>  tools/testing/cxl/Kbuild                |    3 +-
>  tools/testing/cxl/test/mem.c            | 1019 +++++++++++++++++++++++++++----
>  27 files changed, 3568 insertions(+), 332 deletions(-)
> ---
> base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
> change-id: 20230604-dcd-type2-upstream-0cd15f6216fd
> 
> Best regards,


