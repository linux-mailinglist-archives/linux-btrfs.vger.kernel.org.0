Return-Path: <linux-btrfs+bounces-2747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C728862C04
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 17:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B25B20BA0
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3220B18641;
	Sun, 25 Feb 2024 16:54:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF517BB3
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880091; cv=none; b=HIU+oeYCBUgc3y0AW2517QgVH87emhLQFDr/j5QPkfcAY1JvI0It+KYA3u0q6V/21UBRKEWVhAcNV5+tFUS+XTusQBFUmqlBg9Ef3U71ul9rysHyypxbgiWYrg9Wq67JVi4qOeOUqqgTxuKU16Ll8NlNEyMEmRfukTzbPv0JLFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880091; c=relaxed/simple;
	bh=HYmYptU+uSUe8xvs+wnLG3Dq3f5gzj4spCQhIyLt2vM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=THmyjjHSMMwF7ZNrs590mBr0xRhvXijOOLWONLLKsfDpTfHBq2h4NqFPn4euHG/thfCS/cb07hLhYlyvZ/IK/H0td1tjnHDZXAfbG+fS3YUSHabXUZyBv9DUKKqk79hYNCBEqTa9U//HUsyUe9B+qEB7b0lO60yNvvkOACEzxsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-102-MER6aJkKPaSjPChmSL3lxw-1; Sun, 25 Feb 2024 16:54:46 +0000
X-MC-Unique: MER6aJkKPaSjPChmSL3lxw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 25 Feb
 2024 16:54:45 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 25 Feb 2024 16:54:45 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>, 'Netdev'
	<netdev@vger.kernel.org>, "'dri-devel@lists.freedesktop.org'"
	<dri-devel@lists.freedesktop.org>
CC: 'Jens Axboe' <axboe@kernel.dk>, "'Matthew Wilcox (Oracle)'"
	<willy@infradead.org>, 'Christoph Hellwig' <hch@infradead.org>,
	"'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>, "'Andrew
 Morton'" <akpm@linux-foundation.org>, 'Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, "'David S . Miller'"
	<davem@davemloft.net>, 'Dan Carpenter' <dan.carpenter@linaro.org>, "'Jani
 Nikula'" <jani.nikula@linux.intel.com>
Subject: [PATCH next v2 09/11] tree-wide: minmax: Replace all the uses of
 max() for array sizes with max_const()
Thread-Topic: [PATCH next v2 09/11] tree-wide: minmax: Replace all the uses of
 max() for array sizes with max_const()
Thread-Index: AdpoC1PeUhR3U90kTRae/PLire4h2g==
Date: Sun, 25 Feb 2024 16:54:45 +0000
Message-ID: <346b7e12ee6d4f728bcdb7d15ea1ee52@AcuMS.aculab.com>
References: <0fff52305e584036a777f440b5f474da@AcuMS.aculab.com>
In-Reply-To: <0fff52305e584036a777f440b5f474da@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

These are the only uses of max() that require a constant value
from constant parameters.
There don't seem to be any similar uses of min().

Replacing the max() by max_const() lets min()/max() be simplified
speeding up compilation.

max_const() will convert enums to int (or unsigned int) so that the
casts added by max_t() are no longer needed.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c         | 2 +-
 drivers/gpu/drm/drm_color_mgmt.c               | 4 ++--
 drivers/input/touchscreen/cyttsp4_core.c       | 2 +-
 drivers/net/can/usb/etas_es58x/es58x_devlink.c | 2 +-
 fs/btrfs/tree-checker.c                        | 2 +-
 lib/vsprintf.c                                 | 4 ++--
 net/ipv4/proc.c                                | 2 +-
 net/ipv6/proc.c                                | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

Changes for v2:
- Typographical and spelling corrections to the commit messages.
  Patches unchanged.

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 00cd615bbcdc..935fb4014f7c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -708,7 +708,7 @@ static const char *smu_get_feature_name(struct smu_cont=
ext *smu,
 size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 =09=09=09=09   char *buf)
 {
-=09int8_t sort_feature[max(SMU_FEATURE_COUNT, SMU_FEATURE_MAX)];
+=09int8_t sort_feature[max_const(SMU_FEATURE_COUNT, SMU_FEATURE_MAX)];
 =09uint64_t feature_mask;
 =09int i, feature_index;
 =09uint32_t count =3D 0;
diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_m=
gmt.c
index d021497841b8..43a6bd0ca960 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -532,8 +532,8 @@ int drm_plane_create_color_properties(struct drm_plane =
*plane,
 {
 =09struct drm_device *dev =3D plane->dev;
 =09struct drm_property *prop;
-=09struct drm_prop_enum_list enum_list[max_t(int, DRM_COLOR_ENCODING_MAX,
-=09=09=09=09=09=09       DRM_COLOR_RANGE_MAX)];
+=09struct drm_prop_enum_list enum_list[max_const(DRM_COLOR_ENCODING_MAX,
+=09=09=09=09=09=09      DRM_COLOR_RANGE_MAX)];
 =09int i, len;
=20
 =09if (WARN_ON(supported_encodings =3D=3D 0 ||
diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touch=
screen/cyttsp4_core.c
index 7cb26929dc73..c6884c3c3fca 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -871,7 +871,7 @@ static void cyttsp4_get_mt_touches(struct cyttsp4_mt_da=
ta *md, int num_cur_tch)
 =09struct cyttsp4_touch tch;
 =09int sig;
 =09int i, j, t =3D 0;
-=09int ids[max(CY_TMA1036_MAX_TCH, CY_TMA4XX_MAX_TCH)];
+=09int ids[max_const(CY_TMA1036_MAX_TCH, CY_TMA4XX_MAX_TCH)];
=20
 =09memset(ids, 0, si->si_ofs.tch_abs[CY_TCH_T].max * sizeof(int));
 =09for (i =3D 0; i < num_cur_tch; i++) {
diff --git a/drivers/net/can/usb/etas_es58x/es58x_devlink.c b/drivers/net/c=
an/usb/etas_es58x/es58x_devlink.c
index 635edeb8f68c..28fa87668bf8 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_devlink.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
@@ -215,7 +215,7 @@ static int es58x_devlink_info_get(struct devlink *devli=
nk,
 =09struct es58x_sw_version *fw_ver =3D &es58x_dev->firmware_version;
 =09struct es58x_sw_version *bl_ver =3D &es58x_dev->bootloader_version;
 =09struct es58x_hw_revision *hw_rev =3D &es58x_dev->hardware_revision;
-=09char buf[max(sizeof("xx.xx.xx"), sizeof("axxx/xxx"))];
+=09char buf[max_const(sizeof("xx.xx.xx"), sizeof("axxx/xxx"))];
 =09int ret =3D 0;
=20
 =09if (es58x_sw_version_is_valid(fw_ver)) {
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 6eccf8496486..aec4729a9a82 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -615,7 +615,7 @@ static int check_dir_item(struct extent_buffer *leaf,
 =09=09 */
 =09=09if (key->type =3D=3D BTRFS_DIR_ITEM_KEY ||
 =09=09    key->type =3D=3D BTRFS_XATTR_ITEM_KEY) {
-=09=09=09char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
+=09=09=09char namebuf[max_const(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
=20
 =09=09=09read_extent_buffer(leaf, namebuf,
 =09=09=09=09=09(unsigned long)(di + 1), name_len);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 552738f14275..6c3c319afd86 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1080,8 +1080,8 @@ char *resource_string(char *buf, char *end, struct re=
source *res,
 #define FLAG_BUF_SIZE=09=09(2 * sizeof(res->flags))
 #define DECODED_BUF_SIZE=09sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE=09=09sizeof("[mem - flags 0x]")
-=09char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
-=09=09     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
+=09char sym[max_const(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
+=09=09=09   2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
=20
 =09char *p =3D sym, *pend =3D sym + sizeof(sym);
 =09int decode =3D (fmt[0] =3D=3D 'R') ? 1 : 0;
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 5f4654ebff48..a4aff27f949b 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -43,7 +43,7 @@
 #include <net/sock.h>
 #include <net/raw.h>
=20
-#define TCPUDP_MIB_MAX max_t(u32, UDP_MIB_MAX, TCP_MIB_MAX)
+#define TCPUDP_MIB_MAX max_const(UDP_MIB_MAX, TCP_MIB_MAX)
=20
 /*
  *=09Report socket allocation statistics [mea@utu.fi]
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index 6d1d9221649d..7fedb60aaeac 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -27,7 +27,7 @@
 #include <net/ipv6.h>
=20
 #define MAX4(a, b, c, d) \
-=09max_t(u32, max_t(u32, a, b), max_t(u32, c, d))
+=09max_const(max_const(a, b), max_const(c, d))
 #define SNMP_MIB_MAX MAX4(UDP_MIB_MAX, TCP_MIB_MAX, \
 =09=09=09IPSTATS_MIB_MAX, ICMP_MIB_MAX)
=20
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


