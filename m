Return-Path: <linux-btrfs+bounces-7236-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3EE954B9C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 16:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A652818E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 14:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D681BC9E6;
	Fri, 16 Aug 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOqVqTjr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F541BB684;
	Fri, 16 Aug 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816796; cv=none; b=ZhT0Z1R9o81+FgaynOgBAvX/qqelYyXkbxX8u+SJlrq7b5ZIp1hucPoqc/qOMkNgstDyse1sTrnuQWpo6cQqnhH78UsGwHKPP5x2w+q4ouerwbglFQnndIUf8LDOSMSplDD0KaiWNXWR7k8ufi8342EZzeWlzGnt89hHld1ykJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816796; c=relaxed/simple;
	bh=RhJ8/bX0Gvi+ayp0+c3aj0UfkDltF3nONaVThv5PVHY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fqhs9iJDkMaexy61veBa1kekBlRPZxlPhwzKR0/gXZ1nBxcm7hVkPKZkpJ5bN5sx2jybP2Jg7MX7XF15QsLTsS8oqiVU8QVzze0tMpdPPrcmpe2acAsJUBk9m7RLTxaahuR3sBU7HNmPO4dsHEVgHTxxH5GlRHhU4NU3agPLfl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOqVqTjr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723816794; x=1755352794;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=RhJ8/bX0Gvi+ayp0+c3aj0UfkDltF3nONaVThv5PVHY=;
  b=LOqVqTjr06V5DyPFxIuZDh+ktMOeeShh5118uCVLf0gLavkr1T+ynhuP
   D0tYc+Ql396wx8eTd0hZbvgaI4CeNypIyFcblbWe66Z3lvOUa38Ky1eVI
   OmEihY/C4LbDsgaGCRs4pyK1c2RDU0e6JmR2jnn0Mv7Y3aW38DrP5rrqF
   l7LWQ+6EqDs6g04bs3Be49EgnnmTCx259pTjV0DIqkwvjSXo7A+5pgDnV
   URh85Gdekt7g4KwJjivqXfgAyQFf7etP0cKNbYDNuzry8OK7m/lTHjKX4
   PtQaroq/vDIhqHMoSDA+DLJH0uBfVfF/b6+6br1KEp1/yqCyyZN/5oMBo
   Q==;
X-CSE-ConnectionGUID: 2E/gtRKDQKKCI/Jhw7sl+A==
X-CSE-MsgGUID: jfmyiWF4QrSGPoBqIepwLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22272713"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22272713"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:59:53 -0700
X-CSE-ConnectionGUID: PIfFPdNbSEWvHaKs2XWzjw==
X-CSE-MsgGUID: 7fk/7cAdRw2aB3hpeWvAVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90410970"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 06:59:52 -0700
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 00/25] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Date: Fri, 16 Aug 2024 08:59:48 -0500
Message-Id: <20240816-dcd-type2-upstream-v2-0-20189a10ad7d@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFVbv2YC/4WOzQ6CMBCEX8X0bM12KW305HsYD/1ZpIkCaZFIC
 O9u4YQH9TiT+WZmYolioMROu4lFGkIKbZMF7nfM1aa5EQ8+a4aABSiQ3DvP+7Ej5M8u9ZHMg4P
 zoqwUClV5lkFrEnEbTePqBf1ML4EuUhVe6+rlmnUdUt/GcT0xiMX9uTcIDlwLqwoprKFSnkPT0
 /3g2rU9oxIK/I5abQG8wkJhuUGXJwP+X8dcUWkJTmrSR6G2FfM8vwHHXVq6UwEAAA==
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
 "Li, Ming" <ming4.li@intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723816790; l=12740;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=RhJ8/bX0Gvi+ayp0+c3aj0UfkDltF3nONaVThv5PVHY=;
 b=YbzulL59alQZ9QMP3mnJG05vxAYhO9U6brBF56lRmOPsijlykR3StdaDx/HKnbzj9cEOIUAds
 sRKvpdQXUzACTwC/nVl9C7PEIhKa9u7bnL3i0rS0txZqlaBfuXfwrz0
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

A git tree of this series can be found here:

	https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-08-15

This series requires the CXL memory notifier lock change:

	https://lore.kernel.org/all/20240814-fix-notifiers-v2-1-6bab38192c7c@intel.com/

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

Previous versions of this series[0] resulted in architectural comments
as well as confusion on the architecture based on the organization of
patch series itself.

This version has reordered the patches to clarify the architecture.
It also streamlines extent handling more.

The series still requires the creation of regions and DAX devices to be
synchronized with the Orchestrator and Fabric Manager.  The host kernel
will reject an add extent event if the region is not created yet.  It
will also ignore a release if the DAX device is created and referencing
an extent.

These synchronizations are not anticipated to be an issue with real
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

Great care was taken to keep the extent tracking simple.  Some xarray's
needed to be added but extra software objects were kept to a minimum.

Region extents continue to be tracked as sub-devices of the DAX region.
This ensures that region destruction cleans up all extent allocations
properly.

Due to these major changes all reviews were removed from the larger
patches.  A few of the straight forward patches have kept the tags.

In summary the major functionality of this series includes:

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
	c. Support the more bit by processing a list of extents marked
	   with the more bit together before setting up a response.

- Host response for remove capacity
	a. If no DAX device references the extent; release the extent
	b. If a reference does exist, ignore the request.
	   (Require FM to issue release again.)

- Modify DAX device creation/resize to account for extents within a
  sparse DAX region

- Trace Dynamic Capacity events for debugging

- Add cxl-test infrastructure to allow for faster unit testing
  (See new ndctl branch for cxl-dcd.sh test[1])

Fan Ni's upstream of Qemu DCD was used for testing.

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
	4) Rework DAX device interfaces, memfd has been explored a bit

[0] v1: https://lore.kernel.org/all/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com/
[1] https://github.com/weiny2/ndctl/tree/dcd-region2-2024-08-15

---
Major changes:
- Jonathan: support the more bit
- djbw: Allow more than 1 region per DC partition
- All: Address the many comments on the series.
- iweiny: rebase
- iweiny: Rework the series to make it easier to review and understand
          the flow
- Link to v1: https://lore.kernel.org/r/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com

---
Ira Weiny (13):
      range: Add range_overlaps()
      printk: Add print format (%par) for struct range
      dax: Document dax dev range tuple
      cxl/pci: Delay event buffer allocation
      cxl/region: Refactor common create region code
      cxl/events: Split event msgnum configuration from irq setup
      cxl/pci: Factor out interrupt policy check
      cxl/core: Return endpoint decoder information from region search
      dax/bus: Factor out dev dax resize logic
      dax/region: Create resources on sparse DAX regions
      cxl/region: Read existing extents on region creation
      tools/testing/cxl: Make event logs dynamic
      tools/testing/cxl: Add DC Regions to mock mem data

Navneet Singh (12):
      cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
      cxl/mem: Read dynamic capacity configuration from the device
      cxl/core: Separate region mode from decoder mode
      cxl/region: Add dynamic capacity decoder and region modes
      cxl/hdm: Add dynamic capacity size support to endpoint decoders
      cxl/port: Add endpoint decoder DC mode support to sysfs
      cxl/mem: Expose DCD partition capabilities in sysfs
      cxl/region: Add sparse DAX region support
      cxl/mem: Configure dynamic capacity interrupts
      cxl/extent: Process DCD events and realize region extents
      cxl/region/extent: Expose region extent information in sysfs
      cxl/mem: Trace Dynamic capacity Event Record

 Documentation/ABI/testing/sysfs-bus-cxl   |  68 ++-
 Documentation/core-api/printk-formats.rst |  14 +
 drivers/cxl/core/Makefile                 |   2 +-
 drivers/cxl/core/core.h                   |  33 +-
 drivers/cxl/core/extent.c                 | 467 ++++++++++++++
 drivers/cxl/core/hdm.c                    | 206 ++++++-
 drivers/cxl/core/mbox.c                   | 578 +++++++++++++++++-
 drivers/cxl/core/memdev.c                 | 101 ++-
 drivers/cxl/core/port.c                   |  13 +-
 drivers/cxl/core/region.c                 | 173 ++++--
 drivers/cxl/core/trace.h                  |  65 ++
 drivers/cxl/cxl.h                         | 122 +++-
 drivers/cxl/cxlmem.h                      | 128 +++-
 drivers/cxl/pci.c                         | 123 +++-
 drivers/dax/bus.c                         | 352 +++++++++--
 drivers/dax/bus.h                         |   4 +-
 drivers/dax/cxl.c                         |  73 ++-
 drivers/dax/dax-private.h                 |  39 +-
 drivers/dax/hmem/hmem.c                   |   2 +-
 drivers/dax/pmem.c                        |   2 +-
 fs/btrfs/ordered-data.c                   |  10 +-
 include/linux/cxl-event.h                 |  32 +
 include/linux/range.h                     |   7 +
 lib/vsprintf.c                            |  37 ++
 tools/testing/cxl/Kbuild                  |   3 +-
 tools/testing/cxl/test/mem.c              | 981 ++++++++++++++++++++++++++----
 26 files changed, 3327 insertions(+), 308 deletions(-)
---
base-commit: 3cef9316df4cda21b5bf25e4230221b02050dfa1
change-id: 20230604-dcd-type2-upstream-0cd15f6216fd

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


