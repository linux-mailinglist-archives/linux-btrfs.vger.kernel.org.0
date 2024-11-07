Return-Path: <linux-btrfs+bounces-9385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55AB9C1029
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 21:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCEF1C22526
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 20:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A921893C;
	Thu,  7 Nov 2024 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8Z9IMXN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F9216E02;
	Thu,  7 Nov 2024 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013111; cv=none; b=DIIvYIVhLFYaT/Pizhuez+LBPVCoEo+efZ2qv9PdkGC/og6vv6MpKMrOQEpuZ6+5eBOhAJWOl0G53AIKbp4Er7MaLv4etBU0oT6aEdo9XLhyu0Bxi07X5RXMSIXsSvYoJhwNVWJHiGGPLjyCXStKY5cWtWN5IlMtAw8OmSUgIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013111; c=relaxed/simple;
	bh=ISSjU9gASPTnzALkZkG0O/9o7hIhs8ah0+I4oSQNhqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FPnczXcFKjbSdZ9Qz4zKrtAvFMYJm4NEWYBosx/Dc1CgIKZGG9FQ3jJaIeY7G9PTrTSTIS4S4fEGPivMiGIJLdfv2GG3XpAQPSMX7R2DnkPttjwDABybPmglvwfdRRpPxavNoeoeJIClt+Sk8rihQOT790cuGMi28l7slw91MtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8Z9IMXN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731013109; x=1762549109;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=ISSjU9gASPTnzALkZkG0O/9o7hIhs8ah0+I4oSQNhqk=;
  b=R8Z9IMXNFRaAcpSvs+7cA7Mk07FIPRFH4lfUXRGK+VP4aK++TNQIyuSP
   5gv+7Ov/4xPFtCThKnI7FBuW684MxR/xiBkpUsK6MmfP4kU58ftzYhtWP
   RnO519bgTymUli7SAd7/L+FC2iBL8mTPW/Obl32MuyC5TSBr2qgun/kF9
   TwdKjtT020zdclYuScpnQkSEQJpStPx5wonMXA22FuQGnoU6vY7BDPRZv
   GVWrFigHlOUvo+xjCjEkuHlcDCRR0SaCbN6AJYVLVYwB5ePFNVtbzkvAQ
   UAtNPK6y+FvpOiZFGcZBmgiarH9ye+aq7wfM9g2U7Qxsv1T/mDA4o3BPz
   A==;
X-CSE-ConnectionGUID: wJbZYzpNQJuHoO0oMtaNog==
X-CSE-MsgGUID: W9pqoohuSeKbZrM7b+uC6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30300290"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="30300290"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:28 -0800
X-CSE-ConnectionGUID: AESPcAeiSFeDMvMMIJ0/1g==
X-CSE-MsgGUID: lkv4zfX3RQ6bw1cSbLp0BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="90093541"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.195])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:26 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v7 00/27] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Date: Thu, 07 Nov 2024 14:58:18 -0600
Message-Id: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOopLWcC/4XP206EMBAG4FfZcG3N9DRd9sr3MF70MEgTBdIic
 bPh3S0kKhLUy7+Z/5vprcqUIuXqcrpViaaYY9+VYO5OlW9t90wshpIrAUICgmLBBzZeBxLsbch
 jIvvKwAeuGxQcm1CVorOZmEu28+1S/Tm9DAyJmvi+bn18KrmNeezTdT1i4svrn/smzoAZ7lAq7
 ixp9RC7kV7ufb/qpapAit+rzjiAgEKi0Jvqcskk/t8uCtEYBV4ZMjXHPSE/CQVnjoeEXD7ga1e
 jdxaD2RPqi+AA5pBQhfACORESBQp7Qm8IUR8SuhBnI2vv0Hhp1J7Ab4KDPiRwIbQ3jRVcQUNbY
 p7nD4JXBV1fAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731013104; l=12803;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=ISSjU9gASPTnzALkZkG0O/9o7hIhs8ah0+I4oSQNhqk=;
 b=CYm1GWNe8ZhyqS+rCjxHrMOOYynYVY/9WPWsp8COYc+EmO/8uYNyyyO3/hLRGeutFl4K4Q+pH
 Cv00CPB7e4IC+LFsB2WAiP+jsVfK1QgIyEcUeOgIuq4AOszRp57lpVO
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

A git tree of this series can be found here:

	https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-11-07

This is a quick spin with minor clean ups Dave was going to apply as
well as a couple of clean ups I had slated for after V4 landed.

Series info
===========

This series has 4 parts:

Patch 1: Add core range_overlaps() function
Patch 2-6: CXL clean up/prelim patches
Patch 7-25: Core DCD support
Patch 26-27: cxl_test support

Patches 1-6 have received a lot of review and can be applied to cxl-next
straight away.  While 7-27 may need to wait for Dan review.

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
Changes in v7:
- Pick up review tags
- Ming: Fix setting the more flag
- Link to v6: https://patch.msgid.link/20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com

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

 Documentation/ABI/testing/sysfs-bus-cxl |  125 +++-
 drivers/cxl/core/Makefile               |    2 +-
 drivers/cxl/core/cdat.c                 |   45 +-
 drivers/cxl/core/core.h                 |   34 +-
 drivers/cxl/core/extent.c               |  502 +++++++++++++++
 drivers/cxl/core/hdm.c                  |  231 ++++++-
 drivers/cxl/core/mbox.c                 |  610 +++++++++++++++++-
 drivers/cxl/core/memdev.c               |  128 +++-
 drivers/cxl/core/port.c                 |   19 +-
 drivers/cxl/core/region.c               |  185 ++++--
 drivers/cxl/core/trace.h                |   65 ++
 drivers/cxl/cxl.h                       |  122 +++-
 drivers/cxl/cxlmem.h                    |  132 +++-
 drivers/cxl/pci.c                       |  122 +++-
 drivers/dax/bus.c                       |  356 +++++++++--
 drivers/dax/bus.h                       |    4 +-
 drivers/dax/cxl.c                       |   71 ++-
 drivers/dax/dax-private.h               |   66 +-
 drivers/dax/hmem/hmem.c                 |    2 +-
 drivers/dax/pmem.c                      |    2 +-
 fs/btrfs/ordered-data.c                 |   10 +-
 include/acpi/actbl1.h                   |    2 +
 include/cxl/event.h                     |   32 +
 include/linux/ioport.h                  |    3 +
 include/linux/range.h                   |    8 +
 tools/testing/cxl/Kbuild                |    3 +-
 tools/testing/cxl/test/mem.c            | 1019 +++++++++++++++++++++++++++----
 27 files changed, 3568 insertions(+), 332 deletions(-)
---
base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
change-id: 20230604-dcd-type2-upstream-0cd15f6216fd

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


