Return-Path: <linux-btrfs+bounces-3909-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26018984EB
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 12:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301051F25C4E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1873762F7;
	Thu,  4 Apr 2024 10:20:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACDE757F3;
	Thu,  4 Apr 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226046; cv=none; b=DrrvnWyHVPCLE2Xp7qPQZyvonKFWr7kw94mOlBXJupXZUFiZRpc+VsqJmTLyTd+JxEC3A9LyW1cAQpEv3dgNbf2uVYqz3T+Ol8tD0IYo7W3V1vp4LSu5C+5jsKBCGI/5c0U++dXEKSRHGfAnPzDbucn7qJaG+eAUqmbK1Rzvm4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226046; c=relaxed/simple;
	bh=puj4wN8g1EJ1zYi2PbJr+lmtZs+UB6/tEx0jc2UANVU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sR+kjmxrppiyBJJjbCLcEsB3gPqncdLIAuCOtAmoJ+UGrHn27UeH4p9YESCfwqhePGuEfgnZtIHnvIa0Zor1ey/7lk4oanA/0rZ+jUIDsunUssgqmTodLoUruOmKSDIPpeptDwJvrRgfuTphuzA/dDo/L6YU99u1XRMGqgizLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9HfG4q82z6GBtl;
	Thu,  4 Apr 2024 18:19:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D7B37140C72;
	Thu,  4 Apr 2024 18:20:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 11:20:37 +0100
Date: Thu, 4 Apr 2024 11:20:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-btrfs@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 00/26] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <20240404112036.00001551@Huawei.com>
In-Reply-To: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


I haven't quite gone through the whole patch set yet, so ignore me
if you already have this somewhere, but I'd like to see this info
captured somewhere other than the cover letter. Either some Documentation
files or maybe a bit code comment in appropriate location?

> A Dynamic Capacity Device (DCD) (CXL 3.1 sec 9.13.3) is a CXL memory
> device that allows the memory capacity to change dynamically, without
> the need for resetting the device, reconfiguring HDM decoders, or
> reconfiguring software DAX regions.
>=20
> One of the biggest use cases for Dynamic Capacity is to allow hosts to
> share memory dynamically within a data center without increasing the

Probably good to rephrase to avoid share - given 'sharing' isn't
yet supported.=20
"to access a common pool of memory dynamically ..." maybe?

> per-host attached memory.
>=20
> The general flow for the addition or removal of memory is to have an
> orchestrator coordinate the use of the memory.  Generally there are 5
> actors in such a system, the Orchestrator, Fabric Manager, the Device
> the host sees, the Host Kernel, and a Host User.
>=20
> Typical work flows are shown below.
>=20
> Orchestrator      FM         Device       Host Kernel    Host User
>=20
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

Missing a signal from the FM to orchestrator to say release done.

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

As above, need to let the Orchestrator know it's done (the FM
knows so can pass the info onwards

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

My guess is FM would let the orchestrator know it had some capacity
back?

>     |             |           |            |<- Destroy ---|
>     |             |           |            |   Region     |
>     |             |           |            |              |

No path for async release yet?  I think we will want to add that
soon.  Host rebooting etc may not care to talk directly to the
orchestrator.

>=20
> Previous RFCs of this series[0] resulted in significant architectural
> comments.  Previous versions allowed memory capacity to be accepted by
> the host regardless of the existence of a software region being mapped.
>=20
> With this new patch set the order of the create region and DAX device
> creation must be synchronized with the Orchestrator adding/removing
> capacity.  The host kernel will reject an add extent event if the region
> is not created yet.  It will also ignore a release if the DAX device is
> created and referencing an extent.
>=20
> Neither of these synchronizations are anticipated to be an issue with
> real applications.
>=20
> In order to allow for capacity to be added and removed a new concept of
> a sparse DAX region is introduced.  A sparse DAX region may have 0 or
> more bytes of available space.  The total space depends on the number
> and size of the extents which have been added.
>=20
> Initially it is anticipated that users of the memory will carefully
> coordinate the surfacing of additional capacity with the creation of DAX
> devices which use that capacity.  Therefore, the allocation of the
> memory to DAX devices does not allow for specific associations between
> DAX device and extent.  This keeps allocations very similar to existing
> DAX region behavior.

I don't quite follow.  Is the point that there is only one active dax
dev to which any new extents are added?  Or that a particular set
of extents offered together get put into a new device and next set get
another new device?

>=20
> Great care was taken to greatly simplify extent tracking.  Specifically,
> in comparison to previous versions of the patch set, all extent tracking
> xarrays have been eliminated from the code.  In addition, most of the
> extra software objects and associated referenced counts have been
> eliminated.
>=20
> In this version, extents are tracked purely as sub-devices of the
> region.  This ensures that the region destruction cleans up all extent
> allocations properly.  Device managed callbacks are wired to ensure any
> additional data required for DAX device references are handled
> correctly.
>=20
> Due to these major changes I'm setting this new series to V1.
>=20
> In summary the major functionality of this series includes:
>=20
> - Getting the dynamic capacity (DC) configuration information from cxl
>   devices
>=20
> - Configuring the DC regions reported by hardware
>=20
> - Enhancing the CXL and DAX regions for dynamic capacity support
> 	a. Maintain a logical separation between hardware extents and
> 	   software managed region extents.  This provides an
> 	   abstraction between the layers and should allow for
> 	   interleaving in the future
>=20
> - Get hardware extent lists for endpoint decoders upon
>   region creation.
>=20
> - Adjust extent/region memory available on the following events.
>         a. Add capacity Events
> 	b. Release capacity events
Trivial but fix the indent

>=20
> - Host response for add capacity
> 	a. do not accept the extent if:
> 		If the region does not exist
> 		or an error occurs realizing the extent
> 	B. If the region does exist
b.
> 		realize a DAX region extent with 1:1 mapping (no
> 		interleave yet)
>=20
> - Host response for remove capacity
> 	a. If no DAX devices reference the extent release the extent
> 	b. If a reference does exist, ignore the request.
> 	   (Require FM to issue release again.)
>=20
> - Modify DAX device creation/resize to account for extents within a
>   sparse DAX region
>=20
> - Trace Dynamic Capacity events for debugging
>=20
> - Add cxl-test infrastructure to allow for faster unit testing
>   (See new ndctl branch for cxl-dcd.sh test[1])
>=20
> Fan Ni's latest v5 of Qemu DCD was used for testing.[2]
>=20
> Remaining work:
>=20
> 	1) Integrate the QoS work from Dave Jiang
> 	2) Interleave support
>=20
> Possible additional work depending on requirements:
>=20
> 	1) Allow mapping to specific extents (perhaps based on
> 	   label/tag)
> 	2) Release extents when DAX devices are released if a release
> 	   was previously seen from the device
> 	3) Accept a new extent which extends (but overlaps) an existing
> 	   extent(s)

>=20
> [0] RFC v2: https://lore.kernel.org/r/20230604-dcd-type2-upstream-v2-0-f7=
40c47e7916@intel.com
> [1] https://github.com/weiny2/ndctl/tree/dcd-region2-2024-03-22
> [2] https://lore.kernel.org/all/20240304194331.1586191-1-nifan.cxl@gmail.=
com/
>=20
> ---
> Changes for v1:
> - iweiny: Largely new series
> - iweiny: Remove review tags due to the series being a major rework
> - iweiny: Fix authorship for Navneet patches
> - iweiny: Remove extent xarrays
> - iweiny: Remove kreferences, replace with 1 use count protected under da=
x_rwsem
> - iweiny: Mark all sysfs entries for the 6.10 June 2024 kernel
> - iweiny: Remove gotos
> - iweiny: Fix 0day issues
> - Jonathan Cameron: address comments
> - Navneet Singh: address comments
> - Dan Williams: address comments
> - Dave Jiang: address comments
> - Fan Ni: address comments
> - J=F8rgen Hansen: address comments
> - Link to RFC v2: https://lore.kernel.org/r/20230604-dcd-type2-upstream-v=
2-0-f740c47e7916@intel.com
>=20
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
>=20
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
>=20
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
>  tools/testing/cxl/test/mem.c            | 914 ++++++++++++++++++++++++++=
++----
>  25 files changed, 3152 insertions(+), 302 deletions(-)
> ---
> base-commit: dff54316795991e88a453a095a9322718a34034a
> change-id: 20230604-dcd-type2-upstream-0cd15f6216fd
>=20
> Best regards,


