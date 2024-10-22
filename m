Return-Path: <linux-btrfs+bounces-9077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C8B9AB4AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 19:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C682FB22FA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 17:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F080F1BD4F1;
	Tue, 22 Oct 2024 17:05:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6B91BBBC3;
	Tue, 22 Oct 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616733; cv=none; b=o+gGiXsxBqrLO6S0CxrQBBW3jsPh22/9qQKXeKt8Vu1oFGGU+kYtFnQ6F/AUFyBE9pqQA7TosbQbV5A6se783TRLs3SIl2sVPbCs0+J07caZzsxRY3EdxXCs+nWXnYC55C9+sJROzJnBRKGyxlratWQxHB8Dq7a9I2ubUSLev/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616733; c=relaxed/simple;
	bh=VFdBb/E8tBgmq6gj/L3YEUHUyh5FTnb2lUt5TBKYCQc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akOUBBvud6jGEE1yvOVg2bnN43/pgv5MkMUAW584kI3WhM96kQylQQtTQGEJc4gTIdre+NcuQq6TFZ5JRP7c4xPamkQ7MY6XY3xpdMiRGmaCDGU26jAlK6vrpAzgWsLgV4SRdu+fRjkfJNHaJ6d30ix6gUsUnosCZWs+NyHZMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XXz750qtBz6K7kc;
	Wed, 23 Oct 2024 01:04:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C13E2140B2A;
	Wed, 23 Oct 2024 01:05:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Oct
 2024 19:05:27 +0200
Date: Tue, 22 Oct 2024 18:05:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-btrfs@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, "Li,
 Ming" <ming4.li@intel.com>, Robert Moore <robert.moore@intel.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 00/28] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <20241022180525.00007c43@Huawei.com>
In-Reply-To: <ZxaFtTPjzXBGjEu9@fan>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
	<ZxaFtTPjzXBGjEu9@fan>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 21 Oct 2024 09:47:49 -0700
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Mon, Oct 07, 2024 at 06:16:06PM -0500, Ira Weiny wrote:
> > A git tree of this series can be found here:
> > 
> > 	https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-10-04
> > 
> > Series info
> > ===========
> >   
> 
> Hi Ira,
> I have a question here for DCD.
> 
> For CXL spec 3.0 and later, the output payload of the command "Identify
> memory device" has been expanded to include one extra field (dynamic
> capacity event log size) in Table 8-94. However, in current kernel code,
> we follow cxl spec 2.0 and do not have the field.
> If DCD is supported, it means we have a least a 3.0 device as DCD is a
> 3.0 feature.
> I think we should at lease expand the payload to align with 3.0 even we
> do not use it yet.
> 
> What do you think?
> 
> Btw, we have that already in QEMU, I do not know why it does not trigger
> a out-of-bound access issue in the test.

Ignoring new fields should be fine without needing to care about the
payload size. This stuff is supposed to be backwards compatible so
if it isn't fine we have a problem.  Newer device should always
'work' with older kernel. In this case QEMU is a newer device
(for this command anyway).

Jonathan


> 
> Fan
> 
> > This series has 5 parts:
> > 
> > Patch 1-3: Add %pra printk format for struct range
> > Patch 4: Add core range_overlaps() function
> > Patch 5-6: CXL clean up/prelim patches
> > Patch 7-26: Core DCD support
> > Patch 27-28: cxl_test support
> > 
> > Background
> > ==========
> > 
> > A Dynamic Capacity Device (DCD) (CXL 3.1 sec 9.13.3) is a CXL memory
> > device that allows memory capacity within a region to change
> > dynamically without the need for resetting the device, reconfiguring
> > HDM decoders, or reconfiguring software DAX regions.
> > 
> > One of the biggest use cases for Dynamic Capacity is to allow hosts to
> > share memory dynamically within a data center without increasing the
> > per-host attached memory.
> > 
> > The general flow for the addition or removal of memory is to have an
> > orchestrator coordinate the use of the memory.  Generally there are 5
> > actors in such a system, the Orchestrator, Fabric Manager, the Logical
> > device, the Host Kernel, and a Host User.
> > 
> > Typical work flows are shown below.
> > 
> > Orchestrator      FM         Device       Host Kernel    Host User
> > 
> >     |             |           |            |              |
> >     |-------------- Create region ----------------------->|
> >     |             |           |            |              |
> >     |             |           |            |<-- Create ---|
> >     |             |           |            |    Region    |
> >     |<------------- Signal done --------------------------|
> >     |             |           |            |              |
> >     |-- Add ----->|-- Add --->|--- Add --->|              |
> >     |  Capacity   |  Extent   |   Extent   |              |
> >     |             |           |            |              |
> >     |             |<- Accept -|<- Accept  -|              |
> >     |             |   Extent  |   Extent   |              |
> >     |             |           |            |<- Create --->|
> >     |             |           |            |   DAX dev    |-- Use memory
> >     |             |           |            |              |   |
> >     |             |           |            |              |   |
> >     |             |           |            |<- Release ---| <-+
> >     |             |           |            |   DAX dev    |
> >     |             |           |            |              |
> >     |<------------- Signal done --------------------------|
> >     |             |           |            |              |
> >     |-- Remove -->|- Release->|- Release ->|              |
> >     |  Capacity   |  Extent   |   Extent   |              |
> >     |             |           |            |              |
> >     |             |<- Release-|<- Release -|              |
> >     |             |   Extent  |   Extent   |              |
> >     |             |           |            |              |
> >     |-- Add ----->|-- Add --->|--- Add --->|              |
> >     |  Capacity   |  Extent   |   Extent   |              |
> >     |             |           |            |              |
> >     |             |<- Accept -|<- Accept  -|              |
> >     |             |   Extent  |   Extent   |              |
> >     |             |           |            |<- Create ----|
> >     |             |           |            |   DAX dev    |-- Use memory
> >     |             |           |            |              |   |
> >     |             |           |            |<- Release ---| <-+
> >     |             |           |            |   DAX dev    |
> >     |<------------- Signal done --------------------------|
> >     |             |           |            |              |
> >     |-- Remove -->|- Release->|- Release ->|              |
> >     |  Capacity   |  Extent   |   Extent   |              |
> >     |             |           |            |              |
> >     |             |<- Release-|<- Release -|              |
> >     |             |   Extent  |   Extent   |              |
> >     |             |           |            |              |
> >     |-- Add ----->|-- Add --->|--- Add --->|              |
> >     |  Capacity   |  Extent   |   Extent   |              |
> >     |             |           |            |<- Create ----|
> >     |             |           |            |   DAX dev    |-- Use memory
> >     |             |           |            |              |   |
> >     |-- Remove -->|- Release->|- Release ->|              |   |
> >     |  Capacity   |  Extent   |   Extent   |              |   |
> >     |             |           |            |              |   |
> >     |             |           |     (Release Ignored)     |   |
> >     |             |           |            |              |   |
> >     |             |           |            |<- Release ---| <-+
> >     |             |           |            |   DAX dev    |
> >     |<------------- Signal done --------------------------|
> >     |             |           |            |              |
> >     |             |- Release->|- Release ->|              |
> >     |             |  Extent   |   Extent   |              |
> >     |             |           |            |              |
> >     |             |<- Release-|<- Release -|              |
> >     |             |   Extent  |   Extent   |              |
> >     |             |           |            |<- Destroy ---|
> >     |             |           |            |   Region     |
> >     |             |           |            |              |
> > 
> > Implementation
> > ==============
> > 
> > The series still requires the creation of regions and DAX devices to be
> > closely synchronized with the Orchestrator and Fabric Manager.  The host
> > kernel will reject extents if a region is not yet created.  It also
> > ignores extent release if memory is in use (DAX device created).  These
> > synchronizations are not anticipated to be an issue with real
> > applications.
> > 
> > In order to allow for capacity to be added and removed a new concept of
> > a sparse DAX region is introduced.  A sparse DAX region may have 0 or
> > more bytes of available space.  The total space depends on the number
> > and size of the extents which have been added.
> > 
> > Initially it is anticipated that users of the memory will carefully
> > coordinate the surfacing of additional capacity with the creation of DAX
> > devices which use that capacity.  Therefore, the allocation of the
> > memory to DAX devices does not allow for specific associations between
> > DAX device and extent.  This keeps allocations very similar to existing
> > DAX region behavior.
> > 
> > To keep the DAX memory allocation aligned with the existing DAX devices
> > which do not have tags extents are not allowed to have tags.  Future
> > support for tags is planned.
> > 
> > Great care was taken to keep the extent tracking simple.  Some xarray's
> > needed to be added but extra software objects were kept to a minimum.
> > 
> > Region extents continue to be tracked as sub-devices of the DAX region.
> > This ensures that region destruction cleans up all extent allocations
> > properly.
> > 
> > Some review tags were kept if a patch did not change.
> > 
> > The major functionality of this series includes:
> > 
> > - Getting the dynamic capacity (DC) configuration information from cxl
> >   devices
> > 
> > - Configuring the DC partitions reported by hardware
> > 
> > - Enhancing the CXL and DAX regions for dynamic capacity support
> > 	a. Maintain a logical separation between hardware extents and
> > 	   software managed region extents.  This provides an
> > 	   abstraction between the layers and should allow for
> > 	   interleaving in the future
> > 
> > - Get hardware extent lists for endpoint decoders upon
> >   region creation.
> > 
> > - Adjust extent/region memory available on the following events.
> >         a. Add capacity Events
> > 	b. Release capacity events
> > 
> > - Host response for add capacity
> > 	a. do not accept the extent if:
> > 		If the region does not exist
> > 		or an error occurs realizing the extent
> > 	b. If the region does exist
> > 		realize a DAX region extent with 1:1 mapping (no
> > 		interleave yet)
> > 	c. Support the event more bit by processing a list of extents
> > 	   marked with the more bit together before setting up a
> > 	   response.
> > 
> > - Host response for remove capacity
> > 	a. If no DAX device references the extent; release the extent
> > 	b. If a reference does exist, ignore the request.
> > 	   (Require FM to issue release again.)
> > 
> > - Modify DAX device creation/resize to account for extents within a
> >   sparse DAX region
> > 
> > - Trace Dynamic Capacity events for debugging
> > 
> > - Add cxl-test infrastructure to allow for faster unit testing
> >   (See new ndctl branch for cxl-dcd.sh test[1])
> > 
> > - Only support 0 value extent tags
> > 
> > Fan Ni's upstream of Qemu DCD was used for testing.
> > 
> > Remaining work:
> > 
> > 	1) Allow mapping to specific extents (perhaps based on
> > 	   label/tag)
> > 	   1a) devise region size reporting based on tags
> > 	2) Interleave support
> > 
> > Possible additional work depending on requirements:
> > 
> > 	1) Accept a new extent which extends (but overlaps) an existing
> > 	   extent(s)
> > 	2) Release extents when DAX devices are released if a release
> > 	   was previously seen from the device
> > 	3) Rework DAX device interfaces, memfd has been explored a bit
> > 
> > [1] https://github.com/weiny2/ndctl/tree/dcd-region2-2024-10-01
> > 
> > ---
> > Major changes in v4:
> > - iweiny: rebase to 6.12-rc
> > - iweiny: Add qos data to regions
> > - Jonathan: Fix up shared region detection
> > - Jonathan/jgroves/djbw/iweiny: Ignore 0 value tags
> > - iweiny: Change DCD partition sysfs entries to allow for qos class and
> >   additional parameters per partition
> > - Petr/Andy: s/%par/%pra/
> > - Andy: Share logic between printing struct resource and struct range
> > - Link to v3: https://patch.msgid.link/20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com
> > 
> > ---
> > Ira Weiny (14):
> >       test printk: Add very basic struct resource tests
> >       printk: Add print format (%pra) for struct range
> >       cxl/cdat: Use %pra for dpa range outputs
> >       range: Add range_overlaps()
> >       dax: Document dax dev range tuple
> >       cxl/pci: Delay event buffer allocation
> >       cxl/cdat: Gather DSMAS data for DCD regions
> >       cxl/region: Refactor common create region code
> >       cxl/events: Split event msgnum configuration from irq setup
> >       cxl/pci: Factor out interrupt policy check
> >       cxl/core: Return endpoint decoder information from region search
> >       dax/bus: Factor out dev dax resize logic
> >       tools/testing/cxl: Make event logs dynamic
> >       tools/testing/cxl: Add DC Regions to mock mem data
> > 
> > Navneet Singh (14):
> >       cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
> >       cxl/mem: Read dynamic capacity configuration from the device
> >       cxl/core: Separate region mode from decoder mode
> >       cxl/region: Add dynamic capacity decoder and region modes
> >       cxl/hdm: Add dynamic capacity size support to endpoint decoders
> >       cxl/mem: Expose DCD partition capabilities in sysfs
> >       cxl/port: Add endpoint decoder DC mode support to sysfs
> >       cxl/region: Add sparse DAX region support
> >       cxl/mem: Configure dynamic capacity interrupts
> >       cxl/extent: Process DCD events and realize region extents
> >       cxl/region/extent: Expose region extent information in sysfs
> >       dax/region: Create resources on sparse DAX regions
> >       cxl/region: Read existing extents on region creation
> >       cxl/mem: Trace Dynamic capacity Event Record
> > 
> >  Documentation/ABI/testing/sysfs-bus-cxl   | 120 +++-
> >  Documentation/core-api/printk-formats.rst |  13 +
> >  drivers/cxl/core/Makefile                 |   2 +-
> >  drivers/cxl/core/cdat.c                   |  52 +-
> >  drivers/cxl/core/core.h                   |  33 +-
> >  drivers/cxl/core/extent.c                 | 486 +++++++++++++++
> >  drivers/cxl/core/hdm.c                    | 213 ++++++-
> >  drivers/cxl/core/mbox.c                   | 605 ++++++++++++++++++-
> >  drivers/cxl/core/memdev.c                 | 130 +++-
> >  drivers/cxl/core/port.c                   |  13 +-
> >  drivers/cxl/core/region.c                 | 170 ++++--
> >  drivers/cxl/core/trace.h                  |  65 ++
> >  drivers/cxl/cxl.h                         | 122 +++-
> >  drivers/cxl/cxlmem.h                      | 131 +++-
> >  drivers/cxl/pci.c                         | 123 +++-
> >  drivers/dax/bus.c                         | 352 +++++++++--
> >  drivers/dax/bus.h                         |   4 +-
> >  drivers/dax/cxl.c                         |  72 ++-
> >  drivers/dax/dax-private.h                 |  47 +-
> >  drivers/dax/hmem/hmem.c                   |   2 +-
> >  drivers/dax/pmem.c                        |   2 +-
> >  fs/btrfs/ordered-data.c                   |  10 +-
> >  include/acpi/actbl1.h                     |   2 +
> >  include/cxl/event.h                       |  32 +
> >  include/linux/range.h                     |   7 +
> >  lib/test_printf.c                         |  70 +++
> >  lib/vsprintf.c                            |  55 +-
> >  tools/testing/cxl/Kbuild                  |   3 +-
> >  tools/testing/cxl/test/mem.c              | 960 ++++++++++++++++++++++++++----
> >  29 files changed, 3576 insertions(+), 320 deletions(-)
> > ---
> > base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> > change-id: 20230604-dcd-type2-upstream-0cd15f6216fd
> > 
> > Best regards,
> > -- 
> > Ira Weiny <ira.weiny@intel.com>
> >   
> 


