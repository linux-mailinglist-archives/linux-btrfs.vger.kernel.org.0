Return-Path: <linux-btrfs+bounces-2016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A9C8457D1
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E451F281823
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 12:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48048664B;
	Thu,  1 Feb 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2tweb5/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F5161B5F;
	Thu,  1 Feb 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790330; cv=none; b=AaAqCdsBIAlNeXdoUj5MNy+XT8Es+6YN9FHv9b7C/HIqVOHGKEueOMT6CQUh5o56eVig6BiY9mpJiP8Xov+Ac1RvBcXVG53UwZ/7LYNOCq2Ywdvi/04GhW0SHfEeRMrjUWnyJQRHLnznppdHntZLsIeGeT4j5wnLAvcle7NBuho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790330; c=relaxed/simple;
	bh=NkDaTyoibx2WHJr7Ns5qbacNhccmHuOYBaS1TYdKgSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmjIzMm3Za1jzN/uudLPJL+0nNwVKy/HvXhEXBqCKujzVrLyTwtb6uki0zuJX8NUCG0DxVBUFWo+i5KHVgwtUzTiAqkv2SWzY8zbUAsByPU7ydLqIfHH1Qkej9fP0sHI1dhF1EbyIrb8ufrG+pCgrQm4AZxde5Za/Ji3/MeTkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2tweb5/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706790329; x=1738326329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NkDaTyoibx2WHJr7Ns5qbacNhccmHuOYBaS1TYdKgSU=;
  b=k2tweb5/mcO3KRvEb7Ee4iGsjyV7sRAVWv5cBlNCMcFkUG+A029Z7yfz
   68YzuzIz3NLQB77PgQACTJ8e/aDSq7FOxm3JXAq6RVUJSuGR2Eo5LnUCc
   n/lR+8qg56f2lBmckzz53UlhGGuuP0YD5/pKHOn3rfcpYXQFWtRH+oBLQ
   J/x50wYp23Ndn7BY7W4bNVVV4xe02JIMU9zuJNjCDvKlK8+kLoRfEayHX
   b+V2HqaJD5UGi3o8TbcMdDWsz4IjByCUVMXjC95+T5ZvNwfUe+/iISmKY
   mPoKOqxFFVfmwEnGCW5s6po1ogcmoccMTBdBY5xpxgQxbeh9/lmRjirHG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3747333"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3747333"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:25:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4499238"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 01 Feb 2024 04:25:18 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Ido Schimmel <idosch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com,
	ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v5 21/21] ice: Add support for PFCP hardware offload in switchdev
Date: Thu,  1 Feb 2024 13:22:16 +0100
Message-ID: <20240201122216.2634007-22-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Add support for creating PFCP filters in switchdev mode. Add support
for parsing PFCP-specific tc options: S flag and SEID.

To create a PFCP filter, a special netdev must be created and passed
to tc command:

  ip link add pfcp0 type pfcp
  tc filter add dev eth0 ingress prio 1 flower pfcp_opts \
    1:123/ff:fffffffffffffff0 skip_hw action mirred egress redirect \
    dev pfcp0

Changes in iproute2 [1] are required to be able to use pfcp_opts in tc.

ICE COMMS package is required to create a filter as it contains PFCP
profiles.

Link: https://lore.kernel.org/netdev/20230614091758.11180-1-marcin.szycik@linux.intel.com [1]
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 .../net/ethernet/intel/ice/ice_flex_type.h    |  4 +-
 .../ethernet/intel/ice/ice_protocol_type.h    | 12 +++
 drivers/net/ethernet/intel/ice/ice_switch.h   |  2 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   |  6 ++
 drivers/net/ethernet/intel/ice/ice_ddp.c      |  9 ++
 drivers/net/ethernet/intel/ice/ice_switch.c   | 85 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 58 +++++++++++--
 7 files changed, 169 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_type.h b/drivers/net/ethernet/intel/ice/ice_flex_type.h
index d427a79d001a..817beca591e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_flex_type.h
@@ -93,6 +93,7 @@ enum ice_tunnel_type {
 	TNL_GRETAP,
 	TNL_GTPC,
 	TNL_GTPU,
+	TNL_PFCP,
 	__TNL_TYPE_CNT,
 	TNL_LAST = 0xFF,
 	TNL_ALL = 0xFF,
@@ -358,7 +359,8 @@ enum ice_prof_type {
 	ICE_PROF_TUN_GRE = 0x4,
 	ICE_PROF_TUN_GTPU = 0x8,
 	ICE_PROF_TUN_GTPC = 0x10,
-	ICE_PROF_TUN_ALL = 0x1E,
+	ICE_PROF_TUN_PFCP = 0x20,
+	ICE_PROF_TUN_ALL = 0x3E,
 	ICE_PROF_ALL = 0xFF,
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_protocol_type.h b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
index f6f27361c3cf..755a9c55267c 100644
--- a/drivers/net/ethernet/intel/ice/ice_protocol_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
@@ -43,6 +43,7 @@ enum ice_protocol_type {
 	ICE_NVGRE,
 	ICE_GTP,
 	ICE_GTP_NO_PAY,
+	ICE_PFCP,
 	ICE_PPPOE,
 	ICE_L2TPV3,
 	ICE_VLAN_EX,
@@ -61,6 +62,7 @@ enum ice_sw_tunnel_type {
 	ICE_SW_TUN_NVGRE,
 	ICE_SW_TUN_GTPU,
 	ICE_SW_TUN_GTPC,
+	ICE_SW_TUN_PFCP,
 	ICE_ALL_TUNNELS /* All tunnel types including NVGRE */
 };
 
@@ -202,6 +204,15 @@ struct ice_udp_gtp_hdr {
 	u8 rsvrd;
 };
 
+struct ice_pfcp_hdr {
+	u8 flags;
+	u8 msg_type;
+	__be16 length;
+	__be64 seid;
+	__be32 seq;
+	u8 spare;
+} __packed __aligned(__alignof__(u16));
+
 struct ice_pppoe_hdr {
 	u8 rsrvd_ver_type;
 	u8 rsrvd_code;
@@ -418,6 +429,7 @@ union ice_prot_hdr {
 	struct ice_udp_tnl_hdr tnl_hdr;
 	struct ice_nvgre_hdr nvgre_hdr;
 	struct ice_udp_gtp_hdr gtp_hdr;
+	struct ice_pfcp_hdr pfcp_hdr;
 	struct ice_pppoe_hdr pppoe_hdr;
 	struct ice_l2tpv3_sess_hdr l2tpv3_sess_hdr;
 	struct ice_hw_metadata metadata;
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index db7e501b7e0a..30091a80e7fa 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -21,6 +21,8 @@
 #define ICE_PROFID_IPV6_GTPC_NO_TEID			45
 #define ICE_PROFID_IPV6_GTPU_TEID			46
 #define ICE_PROFID_IPV6_GTPU_IPV6_TCP_INNER		70
+#define ICE_PROFID_IPV4_PFCP_NODE			79
+#define ICE_PROFID_IPV6_PFCP_SESSION			82
 
 #define ICE_SW_RULE_VSI_LIST_SIZE(s, n)		struct_size((s), vsi, (n))
 #define ICE_SW_RULE_RX_TX_HDR_SIZE(s, l)	struct_size((s), hdr_data, (l))
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
index 5d188ad7517a..d84f153517ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
@@ -4,6 +4,9 @@
 #ifndef _ICE_TC_LIB_H_
 #define _ICE_TC_LIB_H_
 
+#include <linux/bits.h>
+#include <net/pfcp.h>
+
 #define ICE_TC_FLWR_FIELD_DST_MAC		BIT(0)
 #define ICE_TC_FLWR_FIELD_SRC_MAC		BIT(1)
 #define ICE_TC_FLWR_FIELD_VLAN			BIT(2)
@@ -34,6 +37,7 @@
 #define ICE_TC_FLWR_FIELD_VLAN_PRIO		BIT(27)
 #define ICE_TC_FLWR_FIELD_CVLAN_PRIO		BIT(28)
 #define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT(29)
+#define ICE_TC_FLWR_FIELD_PFCP_OPTS		BIT(30)
 
 #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF
 
@@ -161,6 +165,8 @@ struct ice_tc_flower_fltr {
 	__be32 tenant_id;
 	struct gtp_pdu_session_info gtp_pdu_info_keys;
 	struct gtp_pdu_session_info gtp_pdu_info_masks;
+	struct pfcp_metadata pfcp_meta_keys;
+	struct pfcp_metadata pfcp_meta_masks;
 	u32 flags;
 	u8 tunnel_type;
 	struct ice_tc_flower_action	action;
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 8b7504a9df31..57278ec71aac 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -721,6 +721,12 @@ static bool ice_is_gtp_c_profile(u16 prof_idx)
 	}
 }
 
+static bool ice_is_pfcp_profile(u16 prof_idx)
+{
+	return prof_idx >= ICE_PROFID_IPV4_PFCP_NODE &&
+	       prof_idx <= ICE_PROFID_IPV6_PFCP_SESSION;
+}
+
 /**
  * ice_get_sw_prof_type - determine switch profile type
  * @hw: pointer to the HW structure
@@ -738,6 +744,9 @@ static enum ice_prof_type ice_get_sw_prof_type(struct ice_hw *hw,
 	if (ice_is_gtp_u_profile(prof_idx))
 		return ICE_PROF_TUN_GTPU;
 
+	if (ice_is_pfcp_profile(prof_idx))
+		return ICE_PROF_TUN_PFCP;
+
 	for (i = 0; i < hw->blk[ICE_BLK_SW].es.fvw; i++) {
 		/* UDP tunnel will have UDP_OF protocol ID and VNI offset */
 		if (fv->ew[i].prot_id == (u8)ICE_PROT_UDP_OF &&
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index f84bab80ca42..0138fc832a23 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -42,6 +42,7 @@ enum {
 	ICE_PKT_KMALLOC		= BIT(9),
 	ICE_PKT_PPPOE		= BIT(10),
 	ICE_PKT_L2TPV3		= BIT(11),
+	ICE_PKT_PFCP		= BIT(12),
 };
 
 struct ice_dummy_pkt_offsets {
@@ -1110,6 +1111,77 @@ ICE_DECLARE_PKT_TEMPLATE(ipv6_gtp) = {
 	0x00, 0x00,
 };
 
+ICE_DECLARE_PKT_OFFSETS(pfcp_session_ipv4) = {
+	{ ICE_MAC_OFOS,		0 },
+	{ ICE_ETYPE_OL,		12 },
+	{ ICE_IPV4_OFOS,	14 },
+	{ ICE_UDP_ILOS,		34 },
+	{ ICE_PFCP,		42 },
+	{ ICE_PROTOCOL_LAST,	0 },
+};
+
+ICE_DECLARE_PKT_TEMPLATE(pfcp_session_ipv4) = {
+	0x00, 0x00, 0x00, 0x00, /* ICE_MAC_OFOS 0 */
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+
+	0x08, 0x00,		/* ICE_ETYPE_OL 12 */
+
+	0x45, 0x00, 0x00, 0x2c, /* ICE_IPV4_OFOS 14 */
+	0x00, 0x01, 0x00, 0x00,
+	0x00, 0x11, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+
+	0x00, 0x00, 0x22, 0x65, /* ICE_UDP_ILOS 34 */
+	0x00, 0x18, 0x00, 0x00,
+
+	0x21, 0x01, 0x00, 0x0c, /* ICE_PFCP 42 */
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+
+	0x00, 0x00,		/* 2 bytes for 4 byte alignment */
+};
+
+ICE_DECLARE_PKT_OFFSETS(pfcp_session_ipv6) = {
+	{ ICE_MAC_OFOS,		0 },
+	{ ICE_ETYPE_OL,		12 },
+	{ ICE_IPV6_OFOS,	14 },
+	{ ICE_UDP_ILOS,		54 },
+	{ ICE_PFCP,		62 },
+	{ ICE_PROTOCOL_LAST,	0 },
+};
+
+ICE_DECLARE_PKT_TEMPLATE(pfcp_session_ipv6) = {
+	0x00, 0x00, 0x00, 0x00, /* ICE_MAC_OFOS 0 */
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+
+	0x86, 0xdd,		/* ICE_ETYPE_OL 12 */
+
+	0x60, 0x00, 0x00, 0x00, /* ICE_IPV6_OFOS 14 */
+	0x00, 0x10, 0x11, 0x00, /* Next header UDP */
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+
+	0x00, 0x00, 0x22, 0x65, /* ICE_UDP_ILOS 54 */
+	0x00, 0x18, 0x00, 0x00,
+
+	0x21, 0x01, 0x00, 0x0c, /* ICE_PFCP 62 */
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+
+	0x00, 0x00,		/* 2 bytes for 4 byte alignment */
+};
+
 ICE_DECLARE_PKT_OFFSETS(pppoe_ipv4_tcp) = {
 	{ ICE_MAC_OFOS,		0 },
 	{ ICE_ETYPE_OL,		12 },
@@ -1343,6 +1415,8 @@ static const struct ice_dummy_pkt_profile ice_dummy_pkt_profiles[] = {
 	ICE_PKT_PROFILE(ipv4_gtpu_ipv4_tcp, ICE_PKT_TUN_GTPU),
 	ICE_PKT_PROFILE(ipv6_gtp, ICE_PKT_TUN_GTPC | ICE_PKT_OUTER_IPV6),
 	ICE_PKT_PROFILE(ipv4_gtpu_ipv4, ICE_PKT_TUN_GTPC),
+	ICE_PKT_PROFILE(pfcp_session_ipv6, ICE_PKT_PFCP | ICE_PKT_OUTER_IPV6),
+	ICE_PKT_PROFILE(pfcp_session_ipv4, ICE_PKT_PFCP),
 	ICE_PKT_PROFILE(pppoe_ipv6_udp, ICE_PKT_PPPOE | ICE_PKT_OUTER_IPV6 |
 					ICE_PKT_INNER_UDP),
 	ICE_PKT_PROFILE(pppoe_ipv6_tcp, ICE_PKT_PPPOE | ICE_PKT_OUTER_IPV6),
@@ -4526,6 +4600,7 @@ static const struct ice_prot_ext_tbl_entry ice_prot_ext[ICE_PROTOCOL_LAST] = {
 	ICE_PROTOCOL_ENTRY(ICE_NVGRE, 0, 2, 4, 6),
 	ICE_PROTOCOL_ENTRY(ICE_GTP, 8, 10, 12, 14, 16, 18, 20, 22),
 	ICE_PROTOCOL_ENTRY(ICE_GTP_NO_PAY, 8, 10, 12, 14),
+	ICE_PROTOCOL_ENTRY(ICE_PFCP, 8, 10, 12, 14, 16, 18, 20, 22),
 	ICE_PROTOCOL_ENTRY(ICE_PPPOE, 0, 2, 4, 6),
 	ICE_PROTOCOL_ENTRY(ICE_L2TPV3, 0, 2, 4, 6, 8, 10),
 	ICE_PROTOCOL_ENTRY(ICE_VLAN_EX, 2, 0),
@@ -4559,6 +4634,7 @@ static struct ice_protocol_entry ice_prot_id_tbl[ICE_PROTOCOL_LAST] = {
 	{ ICE_NVGRE,		ICE_GRE_OF_HW },
 	{ ICE_GTP,		ICE_UDP_OF_HW },
 	{ ICE_GTP_NO_PAY,	ICE_UDP_ILOS_HW },
+	{ ICE_PFCP,		ICE_UDP_ILOS_HW },
 	{ ICE_PPPOE,		ICE_PPPOE_HW },
 	{ ICE_L2TPV3,		ICE_L2TPV3_HW },
 	{ ICE_VLAN_EX,          ICE_VLAN_OF_HW },
@@ -5266,6 +5342,9 @@ ice_get_compat_fv_bitmap(struct ice_hw *hw, struct ice_adv_rule_info *rinfo,
 	case ICE_SW_TUN_GTPC:
 		prof_type = ICE_PROF_TUN_GTPC;
 		break;
+	case ICE_SW_TUN_PFCP:
+		prof_type = ICE_PROF_TUN_PFCP;
+		break;
 	case ICE_SW_TUN_AND_NON_TUN:
 	default:
 		prof_type = ICE_PROF_ALL;
@@ -5548,6 +5627,9 @@ ice_find_dummy_packet(struct ice_adv_lkup_elem *lkups, u16 lkups_cnt,
 	case ICE_SW_TUN_VXLAN:
 		match |= ICE_PKT_TUN_UDP;
 		break;
+	case ICE_SW_TUN_PFCP:
+		match |= ICE_PKT_PFCP;
+		break;
 	default:
 		break;
 	}
@@ -5688,6 +5770,9 @@ ice_fill_adv_dummy_packet(struct ice_adv_lkup_elem *lkups, u16 lkups_cnt,
 		case ICE_GTP:
 			len = sizeof(struct ice_udp_gtp_hdr);
 			break;
+		case ICE_PFCP:
+			len = sizeof(struct ice_pfcp_hdr);
+			break;
 		case ICE_PPPOE:
 			len = sizeof(struct ice_pppoe_hdr);
 			break;
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 80797db9f2b9..2f2fce285ecd 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -38,6 +38,9 @@ ice_tc_count_lkups(u32 flags, struct ice_tc_flower_lyr_2_4_hdrs *headers,
 	if (flags & ICE_TC_FLWR_FIELD_GTP_OPTS)
 		lkups_cnt++;
 
+	if (flags & ICE_TC_FLWR_FIELD_PFCP_OPTS)
+		lkups_cnt++;
+
 	if (flags & (ICE_TC_FLWR_FIELD_ENC_SRC_IPV4 |
 		     ICE_TC_FLWR_FIELD_ENC_DEST_IPV4 |
 		     ICE_TC_FLWR_FIELD_ENC_SRC_IPV6 |
@@ -138,6 +141,8 @@ ice_proto_type_from_tunnel(enum ice_tunnel_type type)
 		return ICE_GTP;
 	case TNL_GTPC:
 		return ICE_GTP_NO_PAY;
+	case TNL_PFCP:
+		return ICE_PFCP;
 	default:
 		return 0;
 	}
@@ -157,6 +162,8 @@ ice_sw_type_from_tunnel(enum ice_tunnel_type type)
 		return ICE_SW_TUN_GTPU;
 	case TNL_GTPC:
 		return ICE_SW_TUN_GTPC;
+	case TNL_PFCP:
+		return ICE_SW_TUN_PFCP;
 	default:
 		return ICE_NON_TUN;
 	}
@@ -236,6 +243,22 @@ ice_tc_fill_tunnel_outer(u32 flags, struct ice_tc_flower_fltr *fltr,
 		i++;
 	}
 
+	if (flags & ICE_TC_FLWR_FIELD_PFCP_OPTS) {
+		struct ice_pfcp_hdr *hdr_h, *hdr_m;
+
+		hdr_h = &list[i].h_u.pfcp_hdr;
+		hdr_m = &list[i].m_u.pfcp_hdr;
+		list[i].type = ICE_PFCP;
+
+		hdr_h->flags = fltr->pfcp_meta_keys.type;
+		hdr_m->flags = fltr->pfcp_meta_masks.type & 0x01;
+
+		hdr_h->seid = fltr->pfcp_meta_keys.seid;
+		hdr_m->seid = fltr->pfcp_meta_masks.seid;
+
+		i++;
+	}
+
 	if (flags & (ICE_TC_FLWR_FIELD_ENC_SRC_IPV4 |
 		     ICE_TC_FLWR_FIELD_ENC_DEST_IPV4)) {
 		list[i].type = ice_proto_type_from_ipv4(false);
@@ -366,8 +389,11 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
 	if (tc_fltr->tunnel_type != TNL_LAST) {
 		i = ice_tc_fill_tunnel_outer(flags, tc_fltr, list, i);
 
-		headers = &tc_fltr->inner_headers;
-		inner = true;
+		/* PFCP is considered non-tunneled - don't swap headers. */
+		if (tc_fltr->tunnel_type != TNL_PFCP) {
+			headers = &tc_fltr->inner_headers;
+			inner = true;
+		}
 	}
 
 	if (flags & ICE_TC_FLWR_FIELD_ETH_TYPE_ID) {
@@ -621,6 +647,8 @@ static int ice_tc_tun_get_type(struct net_device *tunnel_dev)
 	 */
 	if (netif_is_gtp(tunnel_dev))
 		return TNL_GTPU;
+	if (netif_is_pfcp(tunnel_dev))
+		return TNL_PFCP;
 	return TNL_LAST;
 }
 
@@ -1415,6 +1443,20 @@ ice_parse_tunnel_attr(struct net_device *dev, struct flow_rule *rule,
 		fltr->flags |= ICE_TC_FLWR_FIELD_GTP_OPTS;
 	}
 
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ENC_OPTS) &&
+	    fltr->tunnel_type == TNL_PFCP) {
+		struct flow_match_enc_opts match;
+
+		flow_rule_match_enc_opts(rule, &match);
+
+		memcpy(&fltr->pfcp_meta_keys, match.key->data,
+		       sizeof(struct pfcp_metadata));
+		memcpy(&fltr->pfcp_meta_masks, match.mask->data,
+		       sizeof(struct pfcp_metadata));
+
+		fltr->flags |= ICE_TC_FLWR_FIELD_PFCP_OPTS;
+	}
+
 	return 0;
 }
 
@@ -1473,10 +1515,14 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 			return err;
 		}
 
-		/* header pointers should point to the inner headers, outer
-		 * header were already set by ice_parse_tunnel_attr
-		 */
-		headers = &fltr->inner_headers;
+		/* PFCP is considered non-tunneled - don't swap headers. */
+		if (fltr->tunnel_type != TNL_PFCP) {
+			/* Header pointers should point to the inner headers,
+			 * outer header were already set by
+			 * ice_parse_tunnel_attr().
+			 */
+			headers = &fltr->inner_headers;
+		}
 	} else if (dissector->used_keys &
 		  (BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
 		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
-- 
2.43.0


