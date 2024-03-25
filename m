Return-Path: <linux-btrfs+bounces-3574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AC188B4E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 00:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFD01C3196C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 23:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87628823D5;
	Mon, 25 Mar 2024 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="kIu89AHQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3680C00;
	Mon, 25 Mar 2024 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407715; cv=none; b=okP44X73wRGB/3/LOo5S8ijaUpil6wlpQPRiZBtkt7tkyIEsptxMBfIk0/Jabu4u/h0O8TR7Zik85FscrPaLeNc71KUkYpo295Vnx3xMVAbQdLKvYGAt0lW2Xm12OmfWZ3QUmmO0uw9dfbCeEpttD+GbNKAoibOOu+ZeQ9B2hgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407715; c=relaxed/simple;
	bh=pGelYWSesGbNVG/XxXeoAsq3pYrN4VEi9EG/XhDcCCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkVZj4s/ukPeEInwno5Vm0QOsH9ICNc/4MNVP/bQfby4I37kcnPO4jsWDUpIw1KCkodbDdLAzzPylBljqSGCzYQ2Joco/AaGINBJlHanrEYFQcwCdpOLRa70ZDQsXbfj1Ru2MXjMxo2EYoNIzrb1iFLVfEv89/NMHs4BESsNbk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=kIu89AHQ; arc=none smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 143072C1855;
	Mon, 25 Mar 2024 22:56:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a262.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B467D2C3A47;
	Mon, 25 Mar 2024 22:56:19 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Madly: 630645f44f809046_1711407379945_2575901930
X-MC-Loop-Signature: 1711407379945:2338995249
X-MC-Ingress-Time: 1711407379945
Received: from pdx1-sub0-mail-a262.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.121.28 (trex/6.9.2);
	Mon, 25 Mar 2024 22:56:19 +0000
Received: from offworld (unknown [108.175.208.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a262.dreamhost.com (Postfix) with ESMTPSA id 4V3SwL6Zw5z49;
	Mon, 25 Mar 2024 15:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1711407379;
	bh=yns6TRenEI0BrHKQHDVuKFZ63algNuE6vnQKEMLKhbQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=kIu89AHQSAuj20+il8QKkPjfIKfaMO99Yvs13+s7U3jApyfI6v+oeJtGql5gk+ZTx
	 Wc2l+PfY9ez0xKcUzfUy1g8auNl45COEKm0W3XzYX59s2W8W0p4lCtkmXCSnwt5y7t
	 BhXrWoT3byG1vmFDER+RgqsdvQ7II6NjA2w2roA9iaAdFlWkmQQhvLMgCpz99KMz+h
	 D6q014ATT/34xHZl5OF9pNmzsUOGHt7nulgxz2CE4FurrdqaG2/f3Lw7c15G99runi
	 zDkjBkp51WvOJ+mLPSbHgYvCi1JiETVrN1Qel1AikrT/yIcdCSKm79kfppnrAZV5Wo
	 Mu/esq8fXhVew==
Date: Mon, 25 Mar 2024 15:56:15 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet Singh <navneet.singh@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/26] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <aczotz4a2xv6x4cse3hh5vpk57ekuwqii67pu46okdvdciae7i@qsopoigqhvw5>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-1-b7b00d623625@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240324-dcd-type2-upstream-v1-1-b7b00d623625@intel.com>
User-Agent: NeoMutt/20231221

On Sun, 24 Mar 2024, ira.weiny@intel.com wrote:

>From: Navneet Singh <navneet.singh@intel.com>
>
>Per the CXL 3.1 specification software must check the Command Effects
>Log (CEL) to know if a device supports dynamic capacity (DC).  If the
>device does support DC the specifics of the DC Regions (0-7) are read
>through the mailbox.

I vote to fold this into patch 3, favoring reduced patch count in the
series to trvially enlarging that particular patch.

>Flag DC Device (DCD) commands in a device if they are supported.
>Subsequent patches will key off these bits to configure DCD.

It would be good to mention these here explicitly (if this patch will
live on). For example, that config will be the driver's way of telling
if dcd is enabled or disabled - we could have cases of that zeroed bit
but the rest enabled.

lgtm otherwise.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Signed-off-by: Navneet Singh <navneet.singh@intel.com>
>Co-developed-by: Ira Weiny <ira.weiny@intel.com>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>---
>Changes for v1
>[iweiny: update to latest master]
>[iweiny: update commit message]
>[iweiny: Based on the fix:
>	https://lore.kernel.org/all/20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com/
>[jonathan: remove unneeded format change]
>[jonathan: don't split security code in mbox.c]
>---
> drivers/cxl/core/mbox.c | 33 +++++++++++++++++++++++++++++++++
> drivers/cxl/cxlmem.h    | 15 +++++++++++++++
> 2 files changed, 48 insertions(+)
>
>diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>index 9adda4795eb7..ed4131c6f50b 100644
>--- a/drivers/cxl/core/mbox.c
>+++ b/drivers/cxl/core/mbox.c
>@@ -161,6 +161,34 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
>	}
> }
>
>+static bool cxl_is_dcd_command(u16 opcode)
>+{
>+#define CXL_MBOX_OP_DCD_CMDS 0x48
>+
>+	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
>+}
>+
>+static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds,
>+					u16 opcode)
>+{
>+	switch (opcode) {
>+	case CXL_MBOX_OP_GET_DC_CONFIG:
>+		set_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
>+		break;
>+	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
>+		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds);
>+		break;
>+	case CXL_MBOX_OP_ADD_DC_RESPONSE:
>+		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, mds->dcd_cmds);
>+		break;
>+	case CXL_MBOX_OP_RELEASE_DC:
>+		set_bit(CXL_DCD_ENABLED_RELEASE, mds->dcd_cmds);
>+		break;
>+	default:
>+		break;
>+	}
>+}
>+
> static bool cxl_is_poison_command(u16 opcode)
> {
> #define CXL_MBOX_OP_POISON_CMDS 0x43
>@@ -733,6 +761,11 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>			enabled++;
>		}
>
>+		if (cxl_is_dcd_command(opcode)) {
>+			cxl_set_dcd_cmd_enabled(mds, opcode);
>+			enabled++;
>+		}
>+
>		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
>			enabled ? "enabled" : "unsupported by driver");
>	}
>diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>index 20fb3b35e89e..79a67cff9143 100644
>--- a/drivers/cxl/cxlmem.h
>+++ b/drivers/cxl/cxlmem.h
>@@ -238,6 +238,15 @@ struct cxl_event_state {
>	struct mutex log_lock;
> };
>
>+/* Device enabled DCD commands */
>+enum dcd_cmd_enabled_bits {
>+	CXL_DCD_ENABLED_GET_CONFIG,
>+	CXL_DCD_ENABLED_GET_EXTENT_LIST,
>+	CXL_DCD_ENABLED_ADD_RESPONSE,
>+	CXL_DCD_ENABLED_RELEASE,
>+	CXL_DCD_ENABLED_MAX
>+};
>+
> /* Device enabled poison commands */
> enum poison_cmd_enabled_bits {
>	CXL_POISON_ENABLED_LIST,
>@@ -454,6 +463,7 @@ struct cxl_dev_state {
>  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
>  * @mbox_mutex: Mutex to synchronize mailbox access.
>  * @firmware_version: Firmware version for the memory device.
>+ * @dcd_cmds: List of DCD commands implemented by memory device
>  * @enabled_cmds: Hardware commands found enabled in CEL.
>  * @exclusive_cmds: Commands that are kernel-internal only
>  * @total_bytes: sum of all possible capacities
>@@ -481,6 +491,7 @@ struct cxl_memdev_state {
>	size_t lsa_size;
>	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>	char firmware_version[0x10];
>+	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
>	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>	u64 total_bytes;
>@@ -551,6 +562,10 @@ enum cxl_opcode {
>	CXL_MBOX_OP_UNLOCK		= 0x4503,
>	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
>+	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
>+	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
>+	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
>+	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
>	CXL_MBOX_OP_MAX			= 0x10000
> };
>
>
>--
>2.44.0
>

