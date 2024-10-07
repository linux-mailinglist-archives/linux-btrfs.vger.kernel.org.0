Return-Path: <linux-btrfs+bounces-8600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23C6993AB2
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 01:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55291C22AB5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD3191F8C;
	Mon,  7 Oct 2024 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egLonC1B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2A18BC3B;
	Mon,  7 Oct 2024 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342975; cv=none; b=SpdnTGCuWeDvLkekJ/oZl/N7cJ82HceFFNkgthRZ62zFgCYyam2jw1DrvmtwmbMvHBgpzVJqXMct72yze4RT/3HAwyrbCBEcSTILBZO41PXaFC+ySt5U/F8R3QhXB612ozW6OBNQ9EQgUe0iZFT9Bo+Ljd4wPJYAZ4fmoDQm0g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342975; c=relaxed/simple;
	bh=OXoiarDQ/wZQh9c1DY7NZJoQbq5qxwtTSLb2/K7p9vg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MKuCZRAIRYVUzrOriui5Yn/hQgzWQlxjkB2BzA/77X6KuR7uZ6w/mXI7tzVUAlRx+970q2eWQznyL9v7cmlz1FRp7COf/fZP/GvdxFaM2LZ5dzEzsKAP4YmpFUfAt6YhVnSVRYOC3EGnCXEXufB8wUzo/n9FLnHK085uYVR91HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egLonC1B; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728342974; x=1759878974;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=OXoiarDQ/wZQh9c1DY7NZJoQbq5qxwtTSLb2/K7p9vg=;
  b=egLonC1Bs+JvqcxuYLqm21Ud3/NjVvKM7/cXIWYxo+ouLdlQREaIckKr
   PPB7C2uCbvi+WolL6F56LbvHsUpqGkLhn1O39Bt2EG0FPvwdHbVyfzlci
   UNnI4kizaQxdYGHNb65dTFBuwuzojMOXQgkzWEQlQ4AefLkR4wkx7nczf
   bfnjAQvnO1LU0b6fW+voX1MlunPSWIYEtaHrz/K+bBl8WPMYOUp6sEXMv
   YeTDqcfKC2OJd2dyHMpMJ1LOywI6TPb34gRd8c8zLvu/5bQ5QSv4J2jnw
   0fTbuGEZX0K+YUUjUEG5X7CKVkNkcN14lQPkgJGbqkj5bbh26RfsBn5gZ
   g==;
X-CSE-ConnectionGUID: AbkELgYJR/OJDQ7HQQM0xA==
X-CSE-MsgGUID: qj9FEI4gS6We1hZ0fNS6wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38078847"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="38078847"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:13 -0700
X-CSE-ConnectionGUID: DhcaiU2SQNmdkSKk+kbcIA==
X-CSE-MsgGUID: fRR9hNG+Spysj393Wiwd6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75634535"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.110.112])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:16:09 -0700
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v4 00/28] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Date: Mon, 07 Oct 2024 18:16:06 -0500
Message-Id: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZrBGcC/4WPy07EMAxFf2WUNUGOkzqUFf+BWOTh0kjQVkmpG
 I367ySVkAbEY3ktn3PtiyicExdxf7qIzFsqaZ5qMDcnEUY3PbNMsWaBgBoIjIwhyvW8MMq3pay
 Z3auEEFU3ECoaoqigd4Wlz24KY0O/breFJfOQ3o/Wx6eax1TWOZ+PIzbVpn/2bUqCtMqTNso77
 sxDmlZ+uQ3zYa+oAY2/o956gEioCbsrtF2y4f/tWBWDNRCMZdsr+q7QnwoDd4p+VOj2QOh9T8E
 7ivZase/7B4Sy1BeWAQAA
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-doc@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 "Li, Ming" <ming4.li@intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728342968; l=13078;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=OXoiarDQ/wZQh9c1DY7NZJoQbq5qxwtTSLb2/K7p9vg=;
 b=OIXwVAQ+2g0diR/ATNYjlq1WJGSxMRZ4G7mzX7Es2yd5P/qZ5jlB/Nh7jJ1Yyk4AYAEasFAI2
 lmZZSVSM9eUBGM1Dw3sq9s50w4BviJbVXmp+O/lTe9BeLe/rK0SzMnH
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

A git tree of this series can be found here:

	https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-10-04

Series info
===========

This series has 5 parts:

Patch 1-3: Add %pra printk format for struct range
Patch 4: Add core range_overlaps() function
Patch 5-6: CXL clean up/prelim patches
Patch 7-26: Core DCD support
Patch 27-28: cxl_test support

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
Major changes in v4:
- iweiny: rebase to 6.12-rc
- iweiny: Add qos data to regions
- Jonathan: Fix up shared region detection
- Jonathan/jgroves/djbw/iweiny: Ignore 0 value tags
- iweiny: Change DCD partition sysfs entries to allow for qos class and
  additional parameters per partition
- Petr/Andy: s/%par/%pra/
- Andy: Share logic between printing struct resource and struct range
- Link to v3: https://patch.msgid.link/20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com

---
Ira Weiny (14):
      test printk: Add very basic struct resource tests
      printk: Add print format (%pra) for struct range
      cxl/cdat: Use %pra for dpa range outputs
      range: Add range_overlaps()
      dax: Document dax dev range tuple
      cxl/pci: Delay event buffer allocation
      cxl/cdat: Gather DSMAS data for DCD regions
      cxl/region: Refactor common create region code
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

 Documentation/ABI/testing/sysfs-bus-cxl   | 120 +++-
 Documentation/core-api/printk-formats.rst |  13 +
 drivers/cxl/core/Makefile                 |   2 +-
 drivers/cxl/core/cdat.c                   |  52 +-
 drivers/cxl/core/core.h                   |  33 +-
 drivers/cxl/core/extent.c                 | 486 +++++++++++++++
 drivers/cxl/core/hdm.c                    | 213 ++++++-
 drivers/cxl/core/mbox.c                   | 605 ++++++++++++++++++-
 drivers/cxl/core/memdev.c                 | 130 +++-
 drivers/cxl/core/port.c                   |  13 +-
 drivers/cxl/core/region.c                 | 170 ++++--
 drivers/cxl/core/trace.h                  |  65 ++
 drivers/cxl/cxl.h                         | 122 +++-
 drivers/cxl/cxlmem.h                      | 131 +++-
 drivers/cxl/pci.c                         | 123 +++-
 drivers/dax/bus.c                         | 352 +++++++++--
 drivers/dax/bus.h                         |   4 +-
 drivers/dax/cxl.c                         |  72 ++-
 drivers/dax/dax-private.h                 |  47 +-
 drivers/dax/hmem/hmem.c                   |   2 +-
 drivers/dax/pmem.c                        |   2 +-
 fs/btrfs/ordered-data.c                   |  10 +-
 include/acpi/actbl1.h                     |   2 +
 include/cxl/event.h                       |  32 +
 include/linux/range.h                     |   7 +
 lib/test_printf.c                         |  70 +++
 lib/vsprintf.c                            |  55 +-
 tools/testing/cxl/Kbuild                  |   3 +-
 tools/testing/cxl/test/mem.c              | 960 ++++++++++++++++++++++++++----
 29 files changed, 3576 insertions(+), 320 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20230604-dcd-type2-upstream-0cd15f6216fd

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


