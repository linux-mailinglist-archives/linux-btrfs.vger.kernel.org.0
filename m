Return-Path: <linux-btrfs+bounces-9339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE0B9BD4CC
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 19:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1431F236EB
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 18:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7F21EABBF;
	Tue,  5 Nov 2024 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/HvX/nJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE901E8856;
	Tue,  5 Nov 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831911; cv=none; b=MydgD/gwtCn4+61y0gXA0E5YbiPbUg2f5CGx4m6YOAJo2V0kx2QN/QLHLi0ZDdgBAsxb7T9w7W5ApscPrLxrQnggFj3RlNhSs5Z7xA51tERmFzI0vJY17CBX5saHqX2KrKXnC+1461042Lgv3JIV3ARL0VrJDpwVgMblVrO9vw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831911; c=relaxed/simple;
	bh=NcAtedjSk0pob1xKBENF3OmGAMVOBAfjEzRoUJ8kt8U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tHbWJDPDDC8TAcp0DhfAOUlNRtuPaH054I98iAPEubKgBZd/EjrQjbvMcFFZSBuNqRHCDF2TCwvZKA67hno29Is8eOAJlR7M7sCq6C8g177jb3bCDBUiilKgjtqzjzygKM96wEIQuGgPXhzdNZtFh0hZWMvpm9C2PgY+Aiy7j4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/HvX/nJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730831909; x=1762367909;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=NcAtedjSk0pob1xKBENF3OmGAMVOBAfjEzRoUJ8kt8U=;
  b=j/HvX/nJn1Q6iTTvYkFyA/IvPtFo2MS8kOeb36Y58KgY/OFtT74ankHU
   AdbZP60F/9zOSML7IZQLgzMHWZPT65lHYHqOZnilAJOwLpDIVc0nhu+th
   ddQEflFHEGKzysaYdo5IEFtKL3zM5Swp4fyBJE/XCKlQ71dNbk0CT20m+
   7WHb93rCz2kLxlCXHUVvhGaWWSUyrOEQ9K3lj/3Ox/TVNEvqavI4i5o6w
   W5Tk6+/bJD6zu+w1emnYwQAglsP0JueWuPPVV92ta7Xs9aJXANJQe/hg1
   Q5B5yRuOd/dtHC8chcKpV4NCLgHKiQpcHNIv6gaNJVY6CTSX2jnyAsN6+
   g==;
X-CSE-ConnectionGUID: mRRgrr/WTsSZFSgcJv1ALQ==
X-CSE-MsgGUID: MxAe7na3TYCNTSD43LKxNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30708345"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="30708345"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:38:28 -0800
X-CSE-ConnectionGUID: D/pBym2mSRy21eis0jcHsA==
X-CSE-MsgGUID: k5ZZ2g3ISNWcKfXI/UK0SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84948616"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO localhost) ([10.125.109.247])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:38:26 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v6 00/27] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Date: Tue, 05 Nov 2024 12:38:22 -0600
Message-Id: <20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB5mKmcC/4XQS07EMAwG4KuMsibIedSZzop7oFnk4dJI0FZJq
 RiNenfSSqBSFVg68v/Zzp1lSpEyu5zuLNEUc+y7UuDDifnWdi/EYyg1kyAVIGgefODjbSDJ34c
 8JrJvHHwQVYNSYBNYCTqbibtkO98u0Z/dS8OQqIkf69Tna6nbmMc+3dYlJrG8/jlvEhy4EQ6VF
 s5SpZ9iN9Lro+9XvUQ1KPl71BkHEFAqlNUmumwyyf+ny0I0RoPXhkwtcE+oL0LDWeAhoZYDfO1
 q9M5iMHtCfxMCwBwSuhBeoiBCokBhT1QbQtaHRFWIs1G1d2i8MttvvM7z/AkuOQuWHAIAAA==
X-Change-ID: 20230604-dcd-type2-upstream-0cd15f6216fd
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 Li Ming <ming4.li@intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730831904; l=12775;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=NcAtedjSk0pob1xKBENF3OmGAMVOBAfjEzRoUJ8kt8U=;
 b=sd8DJio9a8bzHDLhQ0h4iorSsGqxJiLt4WsbO5YCrJOnQjtSlzh8QjIcCVX0Rr3AQc3fxV+pS
 reAU598UUZbDOQlxMIduCVBJQDwPq/xhQ3ZG6NVSlfN2tqx6Tz2++1A
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

A git tree of this series can be found here:

	https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-11-05

This is a quick spin with minor clean ups Dave was going to apply as
well as a couple of clean ups I had slated for after V4 landed.

Series info
===========

This series has 4 parts:

Patch 1: Add core range_overlaps() function
Patch 2-6: CXL clean up/prelim patches
Patch 7-25: Core DCD support
Patch 26-27: cxl_test support

Background
==========

A Dynamic Capacity Device (DCD) (CXL 3.1 sec 9.13.3) is a CXL memory
device that allows memory capacity within a region to change
dynamically without the need for resetting the device, reconfiguring
HDM decoders, or reconfiguring software DAX regions.

One of the biggest use cases for Dynamic Capacity is to allow hosts to
share memory dynamically within a data center without increasing the
per-host attached memory.

The general flow for the addition or removal of memory is to have an
orchestrator coordinate the use of the memory.  Generally there are 5
actors in such a system, the Orchestrator, Fabric Manager, the Logical
device, the Host Kernel, and a Host User.

Typical work flows are shown below.

Orchestrator      FM         Device       Host Kernel    Host User

    |             |           |            |              |
    |-------------- Create region ----------------------->|
    |             |           |            |              |
    |             |           |            |<-- Create ---|
    |             |           |            |    Region    |
    |<------------- Signal done --------------------------|
    |             |           |            |              |
    |-- Add ----->|-- Add --->|--- Add --->|              |
    |  Capacity   |  Extent   |   Extent   |              |
    |             |           |            |              |
    |             |<- Accept -|<- Accept  -|              |
    |             |   Extent  |   Extent   |              |
    |             |           |            |<- Create --->|
    |             |           |            |   DAX dev    |-- Use memory
    |             |           |            |              |   |
    |             |           |            |              |   |
    |             |           |            |<- Release ---| <-+
    |             |           |            |   DAX dev    |
    |             |           |            |              |
    |<------------- Signal done --------------------------|
    |             |           |            |              |
    |-- Remove -->|- Release->|- Release ->|              |
    |  Capacity   |  Extent   |   Extent   |              |
    |             |           |            |              |
    |             |<- Release-|<- Release -|              |
    |             |   Extent  |   Extent   |              |
    |             |           |            |              |
    |-- Add ----->|-- Add --->|--- Add --->|              |
    |  Capacity   |  Extent   |   Extent   |              |
    |             |           |            |              |
    |             |<- Accept -|<- Accept  -|              |
    |             |   Extent  |   Extent   |              |
    |             |           |            |<- Create ----|
    |             |           |            |   DAX dev    |-- Use memory
    |             |           |            |              |   |
    |             |           |            |<- Release ---| <-+
    |             |           |            |   DAX dev    |
    |<------------- Signal done --------------------------|
    |             |           |            |              |
    |-- Remove -->|- Release->|- Release ->|              |
    |  Capacity   |  Extent   |   Extent   |              |
    |             |           |            |              |
    |             |<- Release-|<- Release -|              |
    |             |   Extent  |   Extent   |              |
    |             |           |            |              |
    |-- Add ----->|-- Add --->|--- Add --->|              |
    |  Capacity   |  Extent   |   Extent   |              |
    |             |           |            |<- Create ----|
    |             |           |            |   DAX dev    |-- Use memory
    |             |           |            |              |   |
    |-- Remove -->|- Release->|- Release ->|              |   |
    |  Capacity   |  Extent   |   Extent   |              |   |
    |             |           |            |              |   |
    |             |           |     (Release Ignored)     |   |
    |             |           |            |              |   |
    |             |           |            |<- Release ---| <-+
    |             |           |            |   DAX dev    |
    |<------------- Signal done --------------------------|
    |             |           |            |              |
    |             |- Release->|- Release ->|              |
    |             |  Extent   |   Extent   |              |
    |             |           |            |              |
    |             |<- Release-|<- Release -|              |
    |             |   Extent  |   Extent   |              |
    |             |           |            |<- Destroy ---|
    |             |           |            |   Region     |
    |             |           |            |              |

Implementation
==============

The series still requires the creation of regions and DAX devices to be
closely synchronized with the Orchestrator and Fabric Manager.  The host
kernel will reject extents if a region is not yet created.  It also
ignores extent release if memory is in use (DAX device created).  These
synchronizations are not anticipated to be an issue with real
applications.

In order to allow for capacity to be added and removed a new concept of
a sparse DAX region is introduced.  A sparse DAX region may have 0 or
more bytes of available space.  The total space depends on the number
and size of the extents which have been added.

Initially it is anticipated that users of the memory will carefully
coordinate the surfacing of additional capacity with the creation of DAX
devices which use that capacity.  Therefore, the allocation of the
memory to DAX devices does not allow for specific associations between
DAX device and extent.  This keeps allocations very similar to existing
DAX region behavior.

To keep the DAX memory allocation aligned with the existing DAX devices
which do not have tags extents are not allowed to have tags.  Future
support for tags is planned.

Great care was taken to keep the extent tracking simple.  Some xarray's
needed to be added but extra software objects were kept to a minimum.

Region extents continue to be tracked as sub-devices of the DAX region.
This ensures that region destruction cleans up all extent allocations
properly.

Some review tags were kept if a patch did not change.

The major functionality of this series includes:

- Getting the dynamic capacity (DC) configuration information from cxl
  devices

- Configuring the DC partitions reported by hardware

- Enhancing the CXL and DAX regions for dynamic capacity support
	a. Maintain a logical separation between hardware extents and
	   software managed region extents.  This provides an
	   abstraction between the layers and should allow for
	   interleaving in the future

- Get hardware extent lists for endpoint decoders upon
  region creation.

- Adjust extent/region memory available on the following events.
        a. Add capacity Events
	b. Release capacity events

- Host response for add capacity
	a. do not accept the extent if:
		If the region does not exist
		or an error occurs realizing the extent
	b. If the region does exist
		realize a DAX region extent with 1:1 mapping (no
		interleave yet)
	c. Support the event more bit by processing a list of extents
	   marked with the more bit together before setting up a
	   response.

- Host response for remove capacity
	a. If no DAX device references the extent; release the extent
	b. If a reference does exist, ignore the request.
	   (Require FM to issue release again.)

- Modify DAX device creation/resize to account for extents within a
  sparse DAX region

- Trace Dynamic Capacity events for debugging

- Add cxl-test infrastructure to allow for faster unit testing
  (See new ndctl branch for cxl-dcd.sh test[1])

- Only support 0 value extent tags

Fan Ni's upstream of Qemu DCD was used for testing.

Remaining work:

	1) Allow mapping to specific extents (perhaps based on
	   label/tag)
	   1a) devise region size reporting based on tags
	2) Interleave support

Possible additional work depending on requirements:

	1) Accept a new extent which extends (but overlaps) an existing
	   extent(s)
	2) Release extents when DAX devices are released if a release
	   was previously seen from the device
	3) Rework DAX device interfaces, memfd has been explored a bit

[1] https://github.com/weiny2/ndctl/tree/dcd-region2-2024-10-01

---
Changes in v6:
- Call memory invalidate on extent add to be consistent with the region
  invalidate calls
- Fix counted_by() typo
- Fix typo
- Add xarray.h
- Use UUID for tag debug messages
- Link to v5: https://patch.msgid.link/20241029-dcd-type2-upstream-v5-0-8739cb67c374@intel.com

---
Ira Weiny (13):
      range: Add range_overlaps()
      ACPI/CDAT: Add CDAT/DSMAS shared and read only flag values
      dax: Document struct dev_dax_range
      cxl/pci: Delay event buffer allocation
      cxl/hdm: Use guard() in cxl_dpa_set_mode()
      cxl/region: Refactor common create region code
      cxl/cdat: Gather DSMAS data for DCD regions
      cxl/events: Split event msgnum configuration from irq setup
      cxl/pci: Factor out interrupt policy check
      cxl/core: Return endpoint decoder information from region search
      dax/bus: Factor out dev dax resize logic
      tools/testing/cxl: Make event logs dynamic
      tools/testing/cxl: Add DC Regions to mock mem data

Navneet Singh (14):
      cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
      cxl/mem: Read dynamic capacity configuration from the device
      cxl/core: Separate region mode from decoder mode
      cxl/region: Add dynamic capacity decoder and region modes
      cxl/hdm: Add dynamic capacity size support to endpoint decoders
      cxl/mem: Expose DCD partition capabilities in sysfs
      cxl/port: Add endpoint decoder DC mode support to sysfs
      cxl/region: Add sparse DAX region support
      cxl/mem: Configure dynamic capacity interrupts
      cxl/extent: Process DCD events and realize region extents
      cxl/region/extent: Expose region extent information in sysfs
      dax/region: Create resources on sparse DAX regions
      cxl/region: Read existing extents on region creation
      cxl/mem: Trace Dynamic capacity Event Record

 Documentation/ABI/testing/sysfs-bus-cxl | 125 ++++-
 drivers/cxl/core/Makefile               |   2 +-
 drivers/cxl/core/cdat.c                 |  45 +-
 drivers/cxl/core/core.h                 |  34 +-
 drivers/cxl/core/extent.c               | 502 +++++++++++++++++
 drivers/cxl/core/hdm.c                  | 231 ++++++--
 drivers/cxl/core/mbox.c                 | 610 +++++++++++++++++++-
 drivers/cxl/core/memdev.c               | 128 ++++-
 drivers/cxl/core/port.c                 |  19 +-
 drivers/cxl/core/region.c               | 185 ++++--
 drivers/cxl/core/trace.h                |  65 +++
 drivers/cxl/cxl.h                       | 121 +++-
 drivers/cxl/cxlmem.h                    | 132 ++++-
 drivers/cxl/pci.c                       | 122 ++--
 drivers/dax/bus.c                       | 356 ++++++++++--
 drivers/dax/bus.h                       |   4 +-
 drivers/dax/cxl.c                       |  71 ++-
 drivers/dax/dax-private.h               |  66 ++-
 drivers/dax/hmem/hmem.c                 |   2 +-
 drivers/dax/pmem.c                      |   2 +-
 fs/btrfs/ordered-data.c                 |  10 +-
 include/acpi/actbl1.h                   |   2 +
 include/cxl/event.h                     |  32 ++
 include/linux/ioport.h                  |   3 +
 include/linux/range.h                   |   8 +
 tools/testing/cxl/Kbuild                |   3 +-
 tools/testing/cxl/test/mem.c            | 958 ++++++++++++++++++++++++++++----
 27 files changed, 3506 insertions(+), 332 deletions(-)
---
base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
change-id: 20230604-dcd-type2-upstream-0cd15f6216fd

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


