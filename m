Return-Path: <linux-btrfs+bounces-3527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21758888C83
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 05:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106FBB2A427
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 03:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC32B2A7C75;
	Sun, 24 Mar 2024 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7TsStZA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39715E812;
	Sun, 24 Mar 2024 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322297; cv=none; b=BIRnDFpmyk+f+4kYhakLDLObnVAC/q7xlf5byDnT8/1voYf/M+mYzvPn0HKqsIL2kAZyF3ebX4tSmFpGAZBQog0FVi3UxBNQNpDUPEUjTx4waGiOWJdHny4FtjWAg4Xf50d3ZQwcAW6kTo/HLIFljqGwp87O+TQwGHM+pYTLMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322297; c=relaxed/simple;
	bh=YsiPtmJ8eIW+L0hzv9+vB56liNpeiNAB4lXUIAkgt3c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nArfECuW7Feef3PQTUmAi+qgT/f3WS2IaNmTmmj90j1a7aexJ/uyN2w0vH9uAJ0GbmqJRe1wCg/I6yrSU9sTYfkHUzu4niWul5yLtnx5uNkP/NBwHZ9ch2V5QgfCBI9b44DeZ7OA/8KfNwWyBS3MRngS3Kq0q2HuQMLb+W8sVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7TsStZA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711322295; x=1742858295;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=YsiPtmJ8eIW+L0hzv9+vB56liNpeiNAB4lXUIAkgt3c=;
  b=Z7TsStZAl4tUIPt6b7kKY/nrzuc0ZqnnFar/cRnjITdGMdzyL77/a5Jh
   Sfe0DAx7SDIV6v4BpzIgFvHP86PkIEEdqBNSWnVVoIF6bArlZrabUigpm
   KtVp5Aw1cILMwodLuYJavndiiKRPPHRGo2eEtWLddkAdDYvfIUIlCRlXM
   FMHrIap4boKzXRL+/2iI1tLHiweuEcv3mNsM9vbpvR0JlOeBLlvFm7dLU
   I+WEticlM/ESniJKVJ1zl6KaeZk1LvAFljLLBKlqd0C4EkngRBFVe5CUy
   o1LpUQLxcJOAiAbaJf4/YnB+GQuoANiY57sg558nkLgD8IA64dzcGQmHW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9260896"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9260896"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15842192"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.186.165])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 16:18:06 -0700
From: ira.weiny@intel.com
Subject: [PATCH 00/26] DCD: Add support for Dynamic Capacity Devices (DCD)
Date: Sun, 24 Mar 2024 16:18:03 -0700
Message-Id: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKu0AGYC/4WOyw7CIBBFf6VhLQYohejK/zAueAyWxD4CSGya/
 rvQlW50eSb3njsrihA8RHRuVhQg++insQA9NMj0arwD9rYwYoS1RBCOrbE4LTMw/JxjCqAGTIy
 lnROMCmdRKWoVAeugRtPX6ne6BuYAzr/21eutcO9jmsKyP5Fpvf7cyxQTLKkWLadaQccvfkzwO
 JppQFWX2X8FKwonOTFcgjxR8anYtu0NwUBLPRgBAAA=
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711322284; l=13113;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=YsiPtmJ8eIW+L0hzv9+vB56liNpeiNAB4lXUIAkgt3c=;
 b=ZhdOoQ7bnWwrJwqt/5xBnC4KXDR9opoaMi7KybAKu2JP1wECSAAWnTnO/GmIWH4uoJy5EBadD
 ZynXPSPmnnzCGKU4hv6gAgzzDOWzXXStFNU3Q+exoBr+wutMzX5I49n
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

A git tree of this series can be found here:

	https://github.com/weiny2/linux-kernel/tree/dcd-2024-03-24

Pre-requisite:
==============

	The locking introduced by Vishal for DAX regions:
	https://lore.kernel.org/all/20240124-vv-dax_abi-v7-1-20d16cb8d23d@intel.com/T/#u

Background
==========

A Dynamic Capacity Device (DCD) (CXL 3.1 sec 9.13.3) is a CXL memory
device that allows the memory capacity to change dynamically, without
the need for resetting the device, reconfiguring HDM decoders, or
reconfiguring software DAX regions.

One of the biggest use cases for Dynamic Capacity is to allow hosts to
share memory dynamically within a data center without increasing the
per-host attached memory.

The general flow for the addition or removal of memory is to have an
orchestrator coordinate the use of the memory.  Generally there are 5
actors in such a system, the Orchestrator, Fabric Manager, the Device
the host sees, the Host Kernel, and a Host User.

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

Previous RFCs of this series[0] resulted in significant architectural
comments.  Previous versions allowed memory capacity to be accepted by
the host regardless of the existence of a software region being mapped.

With this new patch set the order of the create region and DAX device
creation must be synchronized with the Orchestrator adding/removing
capacity.  The host kernel will reject an add extent event if the region
is not created yet.  It will also ignore a release if the DAX device is
created and referencing an extent.

Neither of these synchronizations are anticipated to be an issue with
real applications.

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

Great care was taken to greatly simplify extent tracking.  Specifically,
in comparison to previous versions of the patch set, all extent tracking
xarrays have been eliminated from the code.  In addition, most of the
extra software objects and associated referenced counts have been
eliminated.

In this version, extents are tracked purely as sub-devices of the
region.  This ensures that the region destruction cleans up all extent
allocations properly.  Device managed callbacks are wired to ensure any
additional data required for DAX device references are handled
correctly.

Due to these major changes I'm setting this new series to V1.

In summary the major functionality of this series includes:

- Getting the dynamic capacity (DC) configuration information from cxl
  devices

- Configuring the DC regions reported by hardware

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
	B. If the region does exist
		realize a DAX region extent with 1:1 mapping (no
		interleave yet)

- Host response for remove capacity
	a. If no DAX devices reference the extent release the extent
	b. If a reference does exist, ignore the request.
	   (Require FM to issue release again.)

- Modify DAX device creation/resize to account for extents within a
  sparse DAX region

- Trace Dynamic Capacity events for debugging

- Add cxl-test infrastructure to allow for faster unit testing
  (See new ndctl branch for cxl-dcd.sh test[1])

Fan Ni's latest v5 of Qemu DCD was used for testing.[2]

Remaining work:

	1) Integrate the QoS work from Dave Jiang
	2) Interleave support

Possible additional work depending on requirements:

	1) Allow mapping to specific extents (perhaps based on
	   label/tag)
	2) Release extents when DAX devices are released if a release
	   was previously seen from the device
	3) Accept a new extent which extends (but overlaps) an existing
	   extent(s)

[0] RFC v2: https://lore.kernel.org/r/20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com
[1] https://github.com/weiny2/ndctl/tree/dcd-region2-2024-03-22
[2] https://lore.kernel.org/all/20240304194331.1586191-1-nifan.cxl@gmail.com/

---
Changes for v1:
- iweiny: Largely new series
- iweiny: Remove review tags due to the series being a major rework
- iweiny: Fix authorship for Navneet patches
- iweiny: Remove extent xarrays
- iweiny: Remove kreferences, replace with 1 use count protected under dax_rwsem
- iweiny: Mark all sysfs entries for the 6.10 June 2024 kernel
- iweiny: Remove gotos
- iweiny: Fix 0day issues
- Jonathan Cameron: address comments
- Navneet Singh: address comments
- Dan Williams: address comments
- Dave Jiang: address comments
- Fan Ni: address comments
- Jørgen Hansen: address comments
- Link to RFC v2: https://lore.kernel.org/r/20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com

---
Ira Weiny (12):
      cxl/core: Simplify cxl_dpa_set_mode()
      cxl/events: Factor out event msgnum configuration
      cxl/pci: Delay event buffer allocation
      cxl/pci: Factor out interrupt policy check
      range: Add range_overlaps()
      dax/bus: Factor out dev dax resize logic
      dax: Document dax dev range tuple
      dax/region: Prevent range mapping allocation on sparse regions
      dax/region: Support DAX device creation on sparse DAX regions
      tools/testing/cxl: Make event logs dynamic
      tools/testing/cxl: Add DC Regions to mock mem data
      tools/testing/cxl: Add Dynamic Capacity events

Navneet Singh (14):
      cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
      cxl/core: Separate region mode from decoder mode
      cxl/mem: Read dynamic capacity configuration from the device
      cxl/region: Add dynamic capacity decoder and region modes
      cxl/port: Add Dynamic Capacity mode support to endpoint decoders
      cxl/port: Add dynamic capacity size support to endpoint decoders
      cxl/mem: Expose device dynamic capacity capabilities
      cxl/region: Add Dynamic Capacity CXL region support
      cxl/mem: Configure dynamic capacity interrupts
      cxl/region: Read existing extents on region creation
      cxl/extent: Realize extent devices
      dax/region: Create extent resources on DAX region driver load
      cxl/mem: Handle DCD add & release capacity events.
      cxl/mem: Trace Dynamic capacity Event Record

 Documentation/ABI/testing/sysfs-bus-cxl |  60 ++-
 drivers/cxl/core/Makefile               |   1 +
 drivers/cxl/core/core.h                 |  10 +
 drivers/cxl/core/extent.c               | 145 +++++
 drivers/cxl/core/hdm.c                  | 254 +++++++--
 drivers/cxl/core/mbox.c                 | 591 ++++++++++++++++++++-
 drivers/cxl/core/memdev.c               |  76 +++
 drivers/cxl/core/port.c                 |  19 +
 drivers/cxl/core/region.c               | 334 +++++++++++-
 drivers/cxl/core/trace.h                |  65 +++
 drivers/cxl/cxl.h                       | 127 ++++-
 drivers/cxl/cxlmem.h                    | 114 ++++
 drivers/cxl/mem.c                       |  45 ++
 drivers/cxl/pci.c                       | 122 +++--
 drivers/dax/bus.c                       | 353 +++++++++---
 drivers/dax/bus.h                       |   4 +-
 drivers/dax/cxl.c                       | 127 ++++-
 drivers/dax/dax-private.h               |  40 +-
 drivers/dax/hmem/hmem.c                 |   2 +-
 drivers/dax/pmem.c                      |   2 +-
 fs/btrfs/ordered-data.c                 |  10 +-
 include/linux/cxl-event.h               |  31 ++
 include/linux/range.h                   |   7 +
 tools/testing/cxl/Kbuild                |   1 +
 tools/testing/cxl/test/mem.c            | 914 ++++++++++++++++++++++++++++----
 25 files changed, 3152 insertions(+), 302 deletions(-)
---
base-commit: dff54316795991e88a453a095a9322718a34034a
change-id: 20230604-dcd-type2-upstream-0cd15f6216fd

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


