Return-Path: <linux-btrfs+bounces-2010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CC28457B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4431C2423B
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 12:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9B562155;
	Thu,  1 Feb 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZD0TRzvi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D752160897;
	Thu,  1 Feb 2024 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790292; cv=none; b=FXwiz8islFQp2ZriueLkQP3SFGFj5B5Tqgbhq09POs68LcZij95zxBauvbUXp3RjT1+p0jgr18EDhdSBoggy3hCOn/53gVSuIv6zuEmqclFHv/xILtbQQiKqVnMbYwIC+nQeZlwkyuRud/qLlxv9jcHkMuxI9+bIBh4EH4Ppx0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790292; c=relaxed/simple;
	bh=PY20D26vDYYvPHCch+WIf8fAkc34CdjRQfg3SqP3sYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASE224pDH+Pb1+rnD00nOT6KJbKElLNOXQJyNWSRsBQd0Y66Ap9O5CrZ7pMZYO70n1gp+ej7ZoSQb4J5In01qnJ/XT/fVzu9mgbEPl4wv85vexIFKuvVXvY72Y3/t5a9gHVg/vnQlWsnM8xeDN1OAiNtF/mYIyZw51IaaW0RVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZD0TRzvi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706790291; x=1738326291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PY20D26vDYYvPHCch+WIf8fAkc34CdjRQfg3SqP3sYc=;
  b=ZD0TRzvih5TkycLWJs4nk6YA+lZMzf4j/BYUxwSKGQuCuZcVMRhL8nXA
   xRelLXmXiSFeMsd2Wcl2/+exMiQdfegkQUC2gQERe/x7yNbmjsow9FSQG
   5mY6eCbYhHP30pVfuGiRuy3k/160nnqVYIf+D+4vbgqQKl8puu2cbwLmz
   Pq78t9uAXKEKmss7H81qczP1JGqNQiS6Hphqu2wkM4ovXPw3olwU4LE/9
   Sx78LeLzrVC2xUSewGR7Ufy7uVQgVPqIzt9gw2BhjGuHwVSyl4wdXATRi
   e8MBnJ3Cji1tVgB4nIyxRPo/Sc3UJuk7jy4b4bpqjF4EBVAifi6EKT4x8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3747157"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3747157"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:24:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4499145"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 01 Feb 2024 04:24:44 -0800
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
Subject: [PATCH net-next v5 15/21] ip_tunnel: use a separate struct to store tunnel params in the kernel
Date: Thu,  1 Feb 2024 13:22:10 +0100
Message-ID: <20240201122216.2634007-16-aleksander.lobakin@intel.com>
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

Unlike IPv6 tunnels which use purely-kernel __ip6_tnl_parm structure
to store params inside the kernel, IPv4 tunnel code uses the same
ip_tunnel_parm which is being used to talk with the userspace.
This makes it difficult to alter or add any fields or use a
different format for whatever data.
Define struct ip_tunnel_parm_kern, a 1:1 copy of ip_tunnel_parm for
now, and use it throughout the code. Define the pieces, where the copy
user <-> kernel happens, as standalone functions, and copy the data
there field-by-field, so that the kernel-side structure could be easily
modified later on and the users wouldn't have to care about this.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_ipip.h   |  2 +-
 include/linux/netdevice.h                     |  7 ++-
 include/net/ip_tunnels.h                      | 25 ++++++--
 .../ethernet/mellanox/mlxsw/spectrum_ipip.c   | 30 +++++----
 .../ethernet/mellanox/mlxsw/spectrum_span.c   |  4 +-
 net/ipv4/ip_gre.c                             | 17 ++---
 net/ipv4/ip_tunnel.c                          | 63 +++++++++++++++----
 net/ipv4/ip_tunnel_core.c                     |  2 +-
 net/ipv4/ip_vti.c                             | 12 ++--
 net/ipv4/ipip.c                               | 12 ++--
 net/ipv4/ipmr.c                               |  2 +-
 net/ipv6/addrconf.c                           |  3 +-
 net/ipv6/sit.c                                | 33 +++++-----
 13 files changed, 137 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.h
index a35f009da561..a66173779641 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.h
@@ -9,7 +9,7 @@
 #include <linux/if_tunnel.h>
 #include <net/ip6_tunnel.h>
 
-struct ip_tunnel_parm
+struct ip_tunnel_parm_kern
 mlxsw_sp_ipip_netdev_parms4(const struct net_device *ol_dev);
 struct __ip6_tnl_parm
 mlxsw_sp_ipip_netdev_parms6(const struct net_device *ol_dev);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 118c40258d07..d88b4760c518 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -59,7 +59,7 @@ struct ethtool_ops;
 struct kernel_hwtstamp_config;
 struct phy_device;
 struct dsa_port;
-struct ip_tunnel_parm;
+struct ip_tunnel_parm_kern;
 struct macsec_context;
 struct macsec_ops;
 struct netdev_name_node;
@@ -1411,7 +1411,7 @@ struct netdev_net_notifier {
  *	queue id bound to an AF_XDP socket. The flags field specifies if
  *	only RX, only Tx, or both should be woken up using the flags
  *	XDP_WAKEUP_RX and XDP_WAKEUP_TX.
- * int (*ndo_tunnel_ctl)(struct net_device *dev, struct ip_tunnel_parm *p,
+ * int (*ndo_tunnel_ctl)(struct net_device *dev, struct ip_tunnel_parm_kern *p,
  *			 int cmd);
  *	Add, change, delete or get information on an IPv4 tunnel.
  * struct net_device *(*ndo_get_peer_dev)(struct net_device *dev);
@@ -1667,7 +1667,8 @@ struct net_device_ops {
 	int			(*ndo_xsk_wakeup)(struct net_device *dev,
 						  u32 queue_id, u32 flags);
 	int			(*ndo_tunnel_ctl)(struct net_device *dev,
-						  struct ip_tunnel_parm *p, int cmd);
+						  struct ip_tunnel_parm_kern *p,
+						  int cmd);
 	struct net_device *	(*ndo_get_peer_dev)(struct net_device *dev);
 	int                     (*ndo_fill_forward_path)(struct net_device_path_ctx *ctx,
                                                          struct net_device_path *path);
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 2d746f4c9a0a..847ffebaa09b 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -110,6 +110,17 @@ struct ip_tunnel_prl_entry {
 
 struct metadata_dst;
 
+/* Kernel-side copy of ip_tunnel_parm */
+struct ip_tunnel_parm_kern {
+	char			name[IFNAMSIZ];
+	int			link;
+	__be16			i_flags;
+	__be16			o_flags;
+	__be32			i_key;
+	__be32			o_key;
+	struct iphdr		iph;
+};
+
 struct ip_tunnel {
 	struct ip_tunnel __rcu	*next;
 	struct hlist_node hash_node;
@@ -136,7 +147,7 @@ struct ip_tunnel {
 
 	struct dst_cache dst_cache;
 
-	struct ip_tunnel_parm parms;
+	struct ip_tunnel_parm_kern parms;
 
 	int		mlink;
 	int		encap_hlen;	/* Encap header length (FOU,GUE) */
@@ -290,7 +301,11 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		    const struct iphdr *tnl_params, const u8 protocol);
 void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		       const u8 proto, int tunnel_hlen);
-int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm *p, int cmd);
+int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
+		  int cmd);
+bool ip_tunnel_parm_from_user(struct ip_tunnel_parm_kern *kp,
+			      const void __user *data);
+bool ip_tunnel_parm_to_user(void __user *data, struct ip_tunnel_parm_kern *kp);
 int ip_tunnel_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 			     void __user *data, int cmd);
 int __ip_tunnel_change_mtu(struct net_device *dev, int new_mtu, bool strict);
@@ -306,16 +321,16 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		  const struct tnl_ptk_info *tpi, struct metadata_dst *tun_dst,
 		  bool log_ecn_error);
 int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
-			 struct ip_tunnel_parm *p, __u32 fwmark);
+			 struct ip_tunnel_parm_kern *p, __u32 fwmark);
 int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
-		      struct ip_tunnel_parm *p, __u32 fwmark);
+		      struct ip_tunnel_parm_kern *p, __u32 fwmark);
 void ip_tunnel_setup(struct net_device *dev, unsigned int net_id);
 
 bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
 				   struct ip_tunnel_encap *encap);
 
 void ip_tunnel_netlink_parms(struct nlattr *data[],
-			     struct ip_tunnel_parm *parms);
+			     struct ip_tunnel_parm_kern *parms);
 
 extern const struct header_ops ip_tunnel_header_ops;
 __be16 ip_tunnel_parse_protocol(const struct sk_buff *skb);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
index 3340b4a694c3..d67df358a52f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
@@ -8,7 +8,7 @@
 #include "spectrum_ipip.h"
 #include "reg.h"
 
-struct ip_tunnel_parm
+struct ip_tunnel_parm_kern
 mlxsw_sp_ipip_netdev_parms4(const struct net_device *ol_dev)
 {
 	struct ip_tunnel *tun = netdev_priv(ol_dev);
@@ -24,7 +24,8 @@ mlxsw_sp_ipip_netdev_parms6(const struct net_device *ol_dev)
 	return tun->parms;
 }
 
-static bool mlxsw_sp_ipip_parms4_has_ikey(const struct ip_tunnel_parm *parms)
+static bool
+mlxsw_sp_ipip_parms4_has_ikey(const struct ip_tunnel_parm_kern *parms)
 {
 	return !!(parms->i_flags & TUNNEL_KEY);
 }
@@ -34,7 +35,8 @@ static bool mlxsw_sp_ipip_parms6_has_ikey(const struct __ip6_tnl_parm *parms)
 	return !!(parms->i_flags & TUNNEL_KEY);
 }
 
-static bool mlxsw_sp_ipip_parms4_has_okey(const struct ip_tunnel_parm *parms)
+static bool
+mlxsw_sp_ipip_parms4_has_okey(const struct ip_tunnel_parm_kern *parms)
 {
 	return !!(parms->o_flags & TUNNEL_KEY);
 }
@@ -44,7 +46,7 @@ static bool mlxsw_sp_ipip_parms6_has_okey(const struct __ip6_tnl_parm *parms)
 	return !!(parms->o_flags & TUNNEL_KEY);
 }
 
-static u32 mlxsw_sp_ipip_parms4_ikey(const struct ip_tunnel_parm *parms)
+static u32 mlxsw_sp_ipip_parms4_ikey(const struct ip_tunnel_parm_kern *parms)
 {
 	return mlxsw_sp_ipip_parms4_has_ikey(parms) ?
 		be32_to_cpu(parms->i_key) : 0;
@@ -56,7 +58,7 @@ static u32 mlxsw_sp_ipip_parms6_ikey(const struct __ip6_tnl_parm *parms)
 		be32_to_cpu(parms->i_key) : 0;
 }
 
-static u32 mlxsw_sp_ipip_parms4_okey(const struct ip_tunnel_parm *parms)
+static u32 mlxsw_sp_ipip_parms4_okey(const struct ip_tunnel_parm_kern *parms)
 {
 	return mlxsw_sp_ipip_parms4_has_okey(parms) ?
 		be32_to_cpu(parms->o_key) : 0;
@@ -69,7 +71,7 @@ static u32 mlxsw_sp_ipip_parms6_okey(const struct __ip6_tnl_parm *parms)
 }
 
 static union mlxsw_sp_l3addr
-mlxsw_sp_ipip_parms4_saddr(const struct ip_tunnel_parm *parms)
+mlxsw_sp_ipip_parms4_saddr(const struct ip_tunnel_parm_kern *parms)
 {
 	return (union mlxsw_sp_l3addr) { .addr4 = parms->iph.saddr };
 }
@@ -81,7 +83,7 @@ mlxsw_sp_ipip_parms6_saddr(const struct __ip6_tnl_parm *parms)
 }
 
 static union mlxsw_sp_l3addr
-mlxsw_sp_ipip_parms4_daddr(const struct ip_tunnel_parm *parms)
+mlxsw_sp_ipip_parms4_daddr(const struct ip_tunnel_parm_kern *parms)
 {
 	return (union mlxsw_sp_l3addr) { .addr4 = parms->iph.daddr };
 }
@@ -96,7 +98,7 @@ union mlxsw_sp_l3addr
 mlxsw_sp_ipip_netdev_saddr(enum mlxsw_sp_l3proto proto,
 			   const struct net_device *ol_dev)
 {
-	struct ip_tunnel_parm parms4;
+	struct ip_tunnel_parm_kern parms4;
 	struct __ip6_tnl_parm parms6;
 
 	switch (proto) {
@@ -115,7 +117,9 @@ mlxsw_sp_ipip_netdev_saddr(enum mlxsw_sp_l3proto proto,
 static __be32 mlxsw_sp_ipip_netdev_daddr4(const struct net_device *ol_dev)
 {
 
-	struct ip_tunnel_parm parms4 = mlxsw_sp_ipip_netdev_parms4(ol_dev);
+	struct ip_tunnel_parm_kern parms4;
+
+	parms4 = mlxsw_sp_ipip_netdev_parms4(ol_dev);
 
 	return mlxsw_sp_ipip_parms4_daddr(&parms4).addr4;
 }
@@ -124,7 +128,7 @@ static union mlxsw_sp_l3addr
 mlxsw_sp_ipip_netdev_daddr(enum mlxsw_sp_l3proto proto,
 			   const struct net_device *ol_dev)
 {
-	struct ip_tunnel_parm parms4;
+	struct ip_tunnel_parm_kern parms4;
 	struct __ip6_tnl_parm parms6;
 
 	switch (proto) {
@@ -150,7 +154,7 @@ bool mlxsw_sp_l3addr_is_zero(union mlxsw_sp_l3addr addr)
 static struct mlxsw_sp_ipip_parms
 mlxsw_sp_ipip_netdev_parms_init_gre4(const struct net_device *ol_dev)
 {
-	struct ip_tunnel_parm parms = mlxsw_sp_ipip_netdev_parms4(ol_dev);
+	struct ip_tunnel_parm_kern parms = mlxsw_sp_ipip_netdev_parms4(ol_dev);
 
 	return (struct mlxsw_sp_ipip_parms) {
 		.proto = MLXSW_SP_L3_PROTO_IPV4,
@@ -187,8 +191,8 @@ mlxsw_sp_ipip_decap_config_gre4(struct mlxsw_sp *mlxsw_sp,
 {
 	u16 rif_index = mlxsw_sp_ipip_lb_rif_index(ipip_entry->ol_lb);
 	u16 ul_rif_id = mlxsw_sp_ipip_lb_ul_rif_id(ipip_entry->ol_lb);
+	struct ip_tunnel_parm_kern parms;
 	char rtdp_pl[MLXSW_REG_RTDP_LEN];
-	struct ip_tunnel_parm parms;
 	unsigned int type_check;
 	bool has_ikey;
 	u32 daddr4;
@@ -252,7 +256,7 @@ static struct mlxsw_sp_rif_ipip_lb_config
 mlxsw_sp_ipip_ol_loopback_config_gre4(struct mlxsw_sp *mlxsw_sp,
 				      const struct net_device *ol_dev)
 {
-	struct ip_tunnel_parm parms = mlxsw_sp_ipip_netdev_parms4(ol_dev);
+	struct ip_tunnel_parm_kern parms = mlxsw_sp_ipip_netdev_parms4(ol_dev);
 	enum mlxsw_reg_ritr_loopback_ipip_type lb_ipipt;
 
 	lb_ipipt = mlxsw_sp_ipip_parms4_has_okey(&parms) ?
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index af50ff9e5f26..f0cbc6b9b041 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -413,8 +413,8 @@ mlxsw_sp_span_gretap4_route(const struct net_device *to_dev,
 			    __be32 *saddrp, __be32 *daddrp)
 {
 	struct ip_tunnel *tun = netdev_priv(to_dev);
+	struct ip_tunnel_parm_kern parms;
 	struct net_device *dev = NULL;
-	struct ip_tunnel_parm parms;
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
 
@@ -451,7 +451,7 @@ mlxsw_sp_span_entry_gretap4_parms(struct mlxsw_sp *mlxsw_sp,
 				  const struct net_device *to_dev,
 				  struct mlxsw_sp_span_parms *sparmsp)
 {
-	struct ip_tunnel_parm tparm = mlxsw_sp_ipip_netdev_parms4(to_dev);
+	struct ip_tunnel_parm_kern tparm = mlxsw_sp_ipip_netdev_parms4(to_dev);
 	union mlxsw_sp_l3addr saddr = { .addr4 = tparm.iph.saddr };
 	union mlxsw_sp_l3addr daddr = { .addr4 = tparm.iph.daddr };
 	bool inherit_tos = tparm.iph.tos & 0x1;
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5169c3c72cff..04862874dd43 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -785,7 +785,8 @@ static void ipgre_link_update(struct net_device *dev, bool set_mtu)
 	}
 }
 
-static int ipgre_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm *p,
+static int ipgre_tunnel_ctl(struct net_device *dev,
+			    struct ip_tunnel_parm_kern *p,
 			    int cmd)
 {
 	int err;
@@ -1129,7 +1130,7 @@ static int erspan_validate(struct nlattr *tb[], struct nlattr *data[],
 static int ipgre_netlink_parms(struct net_device *dev,
 				struct nlattr *data[],
 				struct nlattr *tb[],
-				struct ip_tunnel_parm *parms,
+				struct ip_tunnel_parm_kern *parms,
 				__u32 *fwmark)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
@@ -1196,7 +1197,7 @@ static int ipgre_netlink_parms(struct net_device *dev,
 static int erspan_netlink_parms(struct net_device *dev,
 				struct nlattr *data[],
 				struct nlattr *tb[],
-				struct ip_tunnel_parm *parms,
+				struct ip_tunnel_parm_kern *parms,
 				__u32 *fwmark)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
@@ -1355,7 +1356,7 @@ static int ipgre_newlink(struct net *src_net, struct net_device *dev,
 			 struct nlattr *tb[], struct nlattr *data[],
 			 struct netlink_ext_ack *extack)
 {
-	struct ip_tunnel_parm p;
+	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = 0;
 	int err;
 
@@ -1373,7 +1374,7 @@ static int erspan_newlink(struct net *src_net, struct net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
-	struct ip_tunnel_parm p;
+	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = 0;
 	int err;
 
@@ -1392,8 +1393,8 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct netlink_ext_ack *extack)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
+	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
-	struct ip_tunnel_parm p;
 	int err;
 
 	err = ipgre_newlink_encap_setup(dev, data);
@@ -1421,8 +1422,8 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 			     struct netlink_ext_ack *extack)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
+	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
-	struct ip_tunnel_parm p;
 	int err;
 
 	err = ipgre_newlink_encap_setup(dev, data);
@@ -1494,7 +1495,7 @@ static size_t ipgre_get_size(const struct net_device *dev)
 static int ipgre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
-	struct ip_tunnel_parm *p = &t->parms;
+	struct ip_tunnel_parm_kern *p = &t->parms;
 	__be16 o_flags = p->o_flags;
 
 	if (nla_put_u32(skb, IFLA_GRE_LINK, p->link) ||
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index beeae624c412..658f46208c8d 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -56,7 +56,7 @@ static unsigned int ip_tunnel_hash(__be32 key, __be32 remote)
 			 IP_TNL_HASH_BITS);
 }
 
-static bool ip_tunnel_key_match(const struct ip_tunnel_parm *p,
+static bool ip_tunnel_key_match(const struct ip_tunnel_parm_kern *p,
 				__be16 flags, __be32 key)
 {
 	if (p->i_flags & TUNNEL_KEY) {
@@ -172,7 +172,7 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 EXPORT_SYMBOL_GPL(ip_tunnel_lookup);
 
 static struct hlist_head *ip_bucket(struct ip_tunnel_net *itn,
-				    struct ip_tunnel_parm *parms)
+				    struct ip_tunnel_parm_kern *parms)
 {
 	unsigned int h;
 	__be32 remote;
@@ -207,7 +207,7 @@ static void ip_tunnel_del(struct ip_tunnel_net *itn, struct ip_tunnel *t)
 }
 
 static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
-					struct ip_tunnel_parm *parms,
+					struct ip_tunnel_parm_kern *parms,
 					int type)
 {
 	__be32 remote = parms->iph.daddr;
@@ -231,7 +231,7 @@ static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
 
 static struct net_device *__ip_tunnel_create(struct net *net,
 					     const struct rtnl_link_ops *ops,
-					     struct ip_tunnel_parm *parms)
+					     struct ip_tunnel_parm_kern *parms)
 {
 	int err;
 	struct ip_tunnel *tunnel;
@@ -327,7 +327,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 
 static struct ip_tunnel *ip_tunnel_create(struct net *net,
 					  struct ip_tunnel_net *itn,
-					  struct ip_tunnel_parm *parms)
+					  struct ip_tunnel_parm_kern *parms)
 {
 	struct ip_tunnel *nt;
 	struct net_device *dev;
@@ -845,7 +845,7 @@ EXPORT_SYMBOL_GPL(ip_tunnel_xmit);
 static void ip_tunnel_update(struct ip_tunnel_net *itn,
 			     struct ip_tunnel *t,
 			     struct net_device *dev,
-			     struct ip_tunnel_parm *p,
+			     struct ip_tunnel_parm_kern *p,
 			     bool set_mtu,
 			     __u32 fwmark)
 {
@@ -877,7 +877,8 @@ static void ip_tunnel_update(struct ip_tunnel_net *itn,
 	netdev_state_change(dev);
 }
 
-int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm *p, int cmd)
+int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
+		  int cmd)
 {
 	int err = 0;
 	struct ip_tunnel *t = netdev_priv(dev);
@@ -979,16 +980,52 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm *p, int cmd)
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_ctl);
 
+bool ip_tunnel_parm_from_user(struct ip_tunnel_parm_kern *kp,
+			      const void __user *data)
+{
+	struct ip_tunnel_parm p;
+
+	if (copy_from_user(&p, data, sizeof(p)))
+		return false;
+
+	strscpy(kp->name, p.name, sizeof(kp->name));
+	kp->link = p.link;
+	kp->i_flags = p.i_flags;
+	kp->o_flags = p.o_flags;
+	kp->i_key = p.i_key;
+	kp->o_key = p.o_key;
+	memcpy(&kp->iph, &p.iph, min(sizeof(kp->iph), sizeof(p.iph)));
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(ip_tunnel_parm_from_user);
+
+bool ip_tunnel_parm_to_user(void __user *data, struct ip_tunnel_parm_kern *kp)
+{
+	struct ip_tunnel_parm p;
+
+	strscpy(p.name, kp->name, sizeof(p.name));
+	p.link = kp->link;
+	p.i_flags = kp->i_flags;
+	p.o_flags = kp->o_flags;
+	p.i_key = kp->i_key;
+	p.o_key = kp->o_key;
+	memcpy(&p.iph, &kp->iph, min(sizeof(p.iph), sizeof(kp->iph)));
+
+	return !copy_to_user(data, &p, sizeof(p));
+}
+EXPORT_SYMBOL_GPL(ip_tunnel_parm_to_user);
+
 int ip_tunnel_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 			     void __user *data, int cmd)
 {
-	struct ip_tunnel_parm p;
+	struct ip_tunnel_parm_kern p;
 	int err;
 
-	if (copy_from_user(&p, data, sizeof(p)))
+	if (!ip_tunnel_parm_from_user(&p, data))
 		return -EFAULT;
 	err = dev->netdev_ops->ndo_tunnel_ctl(dev, &p, cmd);
-	if (!err && copy_to_user(data, &p, sizeof(p)))
+	if (!err && !ip_tunnel_parm_to_user(data, &p))
 		return -EFAULT;
 	return err;
 }
@@ -1067,7 +1104,7 @@ int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 				  struct rtnl_link_ops *ops, char *devname)
 {
 	struct ip_tunnel_net *itn = net_generic(net, ip_tnl_net_id);
-	struct ip_tunnel_parm parms;
+	struct ip_tunnel_parm_kern parms;
 	unsigned int i;
 
 	itn->rtnl_link_ops = ops;
@@ -1147,7 +1184,7 @@ void ip_tunnel_delete_nets(struct list_head *net_list, unsigned int id,
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
 
 int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
-		      struct ip_tunnel_parm *p, __u32 fwmark)
+		      struct ip_tunnel_parm_kern *p, __u32 fwmark)
 {
 	struct ip_tunnel *nt;
 	struct net *net = dev_net(dev);
@@ -1201,7 +1238,7 @@ int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 EXPORT_SYMBOL_GPL(ip_tunnel_newlink);
 
 int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
-			 struct ip_tunnel_parm *p, __u32 fwmark)
+			 struct ip_tunnel_parm_kern *p, __u32 fwmark)
 {
 	struct ip_tunnel *t;
 	struct ip_tunnel *tunnel = netdev_priv(dev);
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 586b1b3e35b8..f89e3bdef123 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -1116,7 +1116,7 @@ bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
 EXPORT_SYMBOL_GPL(ip_tunnel_netlink_encap_parms);
 
 void ip_tunnel_netlink_parms(struct nlattr *data[],
-			     struct ip_tunnel_parm *parms)
+			     struct ip_tunnel_parm_kern *parms)
 {
 	if (data[IFLA_IPTUN_LINK])
 		parms->link = nla_get_u32(data[IFLA_IPTUN_LINK]);
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 9ab9b3ebe0cd..569a54d4bb89 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -167,7 +167,7 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, struct net_device *dev,
 			    struct flowi *fl)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	struct ip_tunnel_parm *parms = &tunnel->parms;
+	struct ip_tunnel_parm_kern *parms = &tunnel->parms;
 	struct dst_entry *dst = skb_dst(skb);
 	struct net_device *tdev;	/* Device to other host */
 	int pkt_len = skb->len;
@@ -373,7 +373,7 @@ static int vti4_err(struct sk_buff *skb, u32 info)
 }
 
 static int
-vti_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm *p, int cmd)
+vti_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p, int cmd)
 {
 	int err = 0;
 
@@ -529,7 +529,7 @@ static int vti_tunnel_validate(struct nlattr *tb[], struct nlattr *data[],
 }
 
 static void vti_netlink_parms(struct nlattr *data[],
-			      struct ip_tunnel_parm *parms,
+			      struct ip_tunnel_parm_kern *parms,
 			      __u32 *fwmark)
 {
 	memset(parms, 0, sizeof(*parms));
@@ -564,7 +564,7 @@ static int vti_newlink(struct net *src_net, struct net_device *dev,
 		       struct nlattr *tb[], struct nlattr *data[],
 		       struct netlink_ext_ack *extack)
 {
-	struct ip_tunnel_parm parms;
+	struct ip_tunnel_parm_kern parms;
 	__u32 fwmark = 0;
 
 	vti_netlink_parms(data, &parms, &fwmark);
@@ -576,8 +576,8 @@ static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct netlink_ext_ack *extack)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
+	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
-	struct ip_tunnel_parm p;
 
 	vti_netlink_parms(data, &p, &fwmark);
 	return ip_tunnel_changelink(dev, tb, &p, fwmark);
@@ -604,7 +604,7 @@ static size_t vti_get_size(const struct net_device *dev)
 static int vti_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
-	struct ip_tunnel_parm *p = &t->parms;
+	struct ip_tunnel_parm_kern *p = &t->parms;
 
 	if (nla_put_u32(skb, IFLA_VTI_LINK, p->link) ||
 	    nla_put_be32(skb, IFLA_VTI_IKEY, p->i_key) ||
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 27b8f83c6ea2..0dd2d3b55c75 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -330,7 +330,7 @@ static bool ipip_tunnel_ioctl_verify_protocol(u8 ipproto)
 }
 
 static int
-ipip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm *p, int cmd)
+ipip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p, int cmd)
 {
 	if (cmd == SIOCADDTUNNEL || cmd == SIOCCHGTUNNEL) {
 		if (p->iph.version != 4 ||
@@ -405,8 +405,8 @@ static int ipip_tunnel_validate(struct nlattr *tb[], struct nlattr *data[],
 }
 
 static void ipip_netlink_parms(struct nlattr *data[],
-			       struct ip_tunnel_parm *parms, bool *collect_md,
-			       __u32 *fwmark)
+			       struct ip_tunnel_parm_kern *parms,
+			       bool *collect_md, __u32 *fwmark)
 {
 	memset(parms, 0, sizeof(*parms));
 
@@ -432,8 +432,8 @@ static int ipip_newlink(struct net *src_net, struct net_device *dev,
 			struct netlink_ext_ack *extack)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
-	struct ip_tunnel_parm p;
 	struct ip_tunnel_encap ipencap;
+	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = 0;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
@@ -452,8 +452,8 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 			   struct netlink_ext_ack *extack)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
-	struct ip_tunnel_parm p;
 	struct ip_tunnel_encap ipencap;
+	struct ip_tunnel_parm_kern p;
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
@@ -510,7 +510,7 @@ static size_t ipip_get_size(const struct net_device *dev)
 static int ipip_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	struct ip_tunnel_parm *parm = &tunnel->parms;
+	struct ip_tunnel_parm_kern *parm = &tunnel->parms;
 
 	if (nla_put_u32(skb, IFLA_IPTUN_LINK, parm->link) ||
 	    nla_put_in_addr(skb, IFLA_IPTUN_LOCAL, parm->iph.saddr) ||
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 9d6f59531b3a..9b8253c00159 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -441,7 +441,7 @@ static bool ipmr_init_vif_indev(const struct net_device *dev)
 static struct net_device *ipmr_new_tunnel(struct net *net, struct vifctl *v)
 {
 	struct net_device *tunnel_dev, *new_dev;
-	struct ip_tunnel_parm p = { };
+	struct ip_tunnel_parm_kern p = { };
 	int err;
 
 	tunnel_dev = __dev_get_by_name(net, "tunl0");
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 733ace18806c..5334fdc388ac 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -63,6 +63,7 @@
 #include <linux/string.h>
 #include <linux/hash.h>
 
+#include <net/ip_tunnels.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
 #include <net/snmp.h>
@@ -2861,7 +2862,7 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *opt, int len, bool sllao)
 static int addrconf_set_sit_dstaddr(struct net *net, struct net_device *dev,
 		struct in6_ifreq *ireq)
 {
-	struct ip_tunnel_parm p = { };
+	struct ip_tunnel_parm_kern p = { };
 	int err;
 
 	if (!(ipv6_addr_type(&ireq->ifr6_addr) & IPV6_ADDR_COMPATv4))
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index cc24cefdb85c..19af34e4c13c 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -132,8 +132,8 @@ static struct ip_tunnel *ipip6_tunnel_lookup(struct net *net,
 	return NULL;
 }
 
-static struct ip_tunnel __rcu **__ipip6_bucket(struct sit_net *sitn,
-		struct ip_tunnel_parm *parms)
+static struct ip_tunnel __rcu **
+__ipip6_bucket(struct sit_net *sitn, struct ip_tunnel_parm_kern *parms)
 {
 	__be32 remote = parms->iph.daddr;
 	__be32 local = parms->iph.saddr;
@@ -226,7 +226,8 @@ static int ipip6_tunnel_create(struct net_device *dev)
 }
 
 static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
-		struct ip_tunnel_parm *parms, int create)
+					     struct ip_tunnel_parm_kern *parms,
+					     int create)
 {
 	__be32 remote = parms->iph.daddr;
 	__be32 local = parms->iph.saddr;
@@ -1135,7 +1136,8 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 	dev->needed_headroom = t_hlen + hlen;
 }
 
-static void ipip6_tunnel_update(struct ip_tunnel *t, struct ip_tunnel_parm *p,
+static void ipip6_tunnel_update(struct ip_tunnel *t,
+				struct ip_tunnel_parm_kern *p,
 				__u32 fwmark)
 {
 	struct net *net = t->net;
@@ -1196,11 +1198,11 @@ static int
 ipip6_tunnel_get6rd(struct net_device *dev, struct ip_tunnel_parm __user *data)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
+	struct ip_tunnel_parm_kern p;
 	struct ip_tunnel_6rd ip6rd;
-	struct ip_tunnel_parm p;
 
 	if (dev == dev_to_sit_net(dev)->fb_tunnel_dev) {
-		if (copy_from_user(&p, data, sizeof(p)))
+		if (!ip_tunnel_parm_from_user(&p, data))
 			return -EFAULT;
 		t = ipip6_tunnel_locate(t->net, &p, 0);
 	}
@@ -1251,7 +1253,7 @@ static bool ipip6_valid_ip_proto(u8 ipproto)
 }
 
 static int
-__ipip6_tunnel_ioctl_validate(struct net *net, struct ip_tunnel_parm *p)
+__ipip6_tunnel_ioctl_validate(struct net *net, struct ip_tunnel_parm_kern *p)
 {
 	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
@@ -1268,7 +1270,7 @@ __ipip6_tunnel_ioctl_validate(struct net *net, struct ip_tunnel_parm *p)
 }
 
 static int
-ipip6_tunnel_get(struct net_device *dev, struct ip_tunnel_parm *p)
+ipip6_tunnel_get(struct net_device *dev, struct ip_tunnel_parm_kern *p)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
 
@@ -1281,7 +1283,7 @@ ipip6_tunnel_get(struct net_device *dev, struct ip_tunnel_parm *p)
 }
 
 static int
-ipip6_tunnel_add(struct net_device *dev, struct ip_tunnel_parm *p)
+ipip6_tunnel_add(struct net_device *dev, struct ip_tunnel_parm_kern *p)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
 	int err;
@@ -1297,7 +1299,7 @@ ipip6_tunnel_add(struct net_device *dev, struct ip_tunnel_parm *p)
 }
 
 static int
-ipip6_tunnel_change(struct net_device *dev, struct ip_tunnel_parm *p)
+ipip6_tunnel_change(struct net_device *dev, struct ip_tunnel_parm_kern *p)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
 	int err;
@@ -1328,7 +1330,7 @@ ipip6_tunnel_change(struct net_device *dev, struct ip_tunnel_parm *p)
 }
 
 static int
-ipip6_tunnel_del(struct net_device *dev, struct ip_tunnel_parm *p)
+ipip6_tunnel_del(struct net_device *dev, struct ip_tunnel_parm_kern *p)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
 
@@ -1348,7 +1350,8 @@ ipip6_tunnel_del(struct net_device *dev, struct ip_tunnel_parm *p)
 }
 
 static int
-ipip6_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm *p, int cmd)
+ipip6_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
+		 int cmd)
 {
 	switch (cmd) {
 	case SIOCGETTUNNEL:
@@ -1494,7 +1497,7 @@ static int ipip6_validate(struct nlattr *tb[], struct nlattr *data[],
 }
 
 static void ipip6_netlink_parms(struct nlattr *data[],
-				struct ip_tunnel_parm *parms,
+				struct ip_tunnel_parm_kern *parms,
 				__u32 *fwmark)
 {
 	memset(parms, 0, sizeof(*parms));
@@ -1603,8 +1606,8 @@ static int ipip6_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct netlink_ext_ack *extack)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
-	struct ip_tunnel_parm p;
 	struct ip_tunnel_encap ipencap;
+	struct ip_tunnel_parm_kern p;
 	struct net *net = t->net;
 	struct sit_net *sitn = net_generic(net, sit_net_id);
 #ifdef CONFIG_IPV6_SIT_6RD
@@ -1691,7 +1694,7 @@ static size_t ipip6_get_size(const struct net_device *dev)
 static int ipip6_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	struct ip_tunnel_parm *parm = &tunnel->parms;
+	struct ip_tunnel_parm_kern *parm = &tunnel->parms;
 
 	if (nla_put_u32(skb, IFLA_IPTUN_LINK, parm->link) ||
 	    nla_put_in_addr(skb, IFLA_IPTUN_LOCAL, parm->iph.saddr) ||
-- 
2.43.0


