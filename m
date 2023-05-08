Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2126FBAF0
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 00:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjEHWOd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 18:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjEHWOc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 18:14:32 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EA211D
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683584070; x=1715120070;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=32YBzWgRxNCTCGHHxdaaNYsDgN50gpqyWAwxvjDbeWw=;
  b=RhZU4FnM46fD2wyufWM7X3/bBVcNhZDLB1pdnZprI2AZHsdUdodGvOO0
   MTT1KZL2iT9R33lZUNJ4M6ciEVl1X/AzMgFqLZLG/jDlOjbrbJ/ov/w9R
   HhdP5y5dpY+HbGqwc7JA6B1BMOFDm67Zb2eiuanCwx/LaIvRxcI+SStaD
   v7y9kIem6jsbBtVOming6eO+N91mbUaJruKMnmDIfNZ61vWFNoT/6H/yj
   x8jMkII9gDFAxxz+f1hptyp8ZcNPBUEHX+Lq9FYSOw/m35wpegdgupUnL
   LZ48356jNDABKxP9LVDkl3V/VxTSbloZlbzMpsBNzDEwhpSI56vddP5uH
   g==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="230208919"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 06:14:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fl/J8uOrQ+EHf3ymGLYDslMEBi+WiKdGWPnfNZ3uBQDbVceC/W3sO9mctG3EXVOequcbdQPgSvWyidDfulADrgvAdMug+6CUydduVDty41eYKWV7TejmCLWiLVElqlUZuR/jGsgSQf/lRYHE055eM0NAAOGkU7WD5Juo+rfIHVFTeOXtPuuz9MNcbH+jIxOIiL8RqdNVyS7kLAJAVjr2Ln3S3il7q88bOAQ/NpdvNACVUcVTPEwRGuVhJ04Q2U0yTSo0EJuJxZWWwhaoTMOMlrgYf+FJNHNwLGA0sOgci5lhSmpTGivttKG6k3mMm04ZgHQv7spHzLDqu2DL+kkbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rP5QQdq4LcJPlODwmDxA3eEC8m2IeKvI1VTIMHJtdM=;
 b=oVkZfv4tUDiJ/QXbfZAxuq8/kRwfWPM3foVCnYB7k2e8O9eLglKy2MB33vMcSpkvUgAHFyIO6iYIt64zyZpXDtNaAVsDtmKW8DqjRSHWeS9kKplUjAFtkkBwjNgulQ738j0zXlxzx7lq8vRFEAIaHHpuin3GZrdpqQCPFwlSz+xrPDs4v3/CT0zE1i0Ts5xLWsyquVcgHrn8ePDQA18y1GTqutCflO/8yFEvtN5NQGyD40kBz8U/3JreNpDChORSpwm9jMhf+kTABupsLaoDfl2pN3hMv0xq9DAa7vaL2MY5sT4B/nmqsLryTWVMX/JJU5pBaWgwqW03wbQkj5Iqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rP5QQdq4LcJPlODwmDxA3eEC8m2IeKvI1VTIMHJtdM=;
 b=nFFxHQ3uEh4JFZa2IMRz3PmnBLEb/0u77d0gMJDbhEBW75Z2ZZfmLxqdUze149Sm/5TecDivU4JHTAvWvi2wogaxO+Xl67pO2BHQy/qeYlh/Z9rNMUX8A688FeTyMP//jPBolw9FqiKTYSRqlUHmIkHJvgtCbwibaWR8dhM34LU=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SN4PR04MB8397.namprd04.prod.outlook.com (2603:10b6:806:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 22:14:28 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 22:14:20 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH] btrfs: zoned: zone finish data relocation BG with last IO
Thread-Topic: [PATCH] btrfs: zoned: zone finish data relocation BG with last
 IO
Thread-Index: AQHZgfpwW8eOxf6qUkmx9bzUdKykjA==
Date:   Mon, 8 May 2023 22:14:20 +0000
Message-ID: <1ccb7d4e3f582369edc1fb067bdd39d867049a0b.1683582405.git.naohiro.aota@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.40.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SN4PR04MB8397:EE_
x-ms-office365-filtering-correlation-id: 3d880802-5ba8-41a0-8146-08db50119297
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J8JA16myvA4QSAkL1SLRlq4YG1PalFr/bnnxXQAqP33wa6IjDVLYMb6VNed1W0sNihHZ9KL4Jbgs2hkw3CLnYToWMpy9gx/J3LKAgKC7BZ3CwOr1+P8i2nljqzwDMZ0dyYXTaHe5nRqW6R/NhaS5wo+G+ErFwEbVYvhCyJSn9UHnOcHP2ZXmjG+GjTWG9zuAjB3gzfdTeuxoQdtwdQNlRcDXY2flzGngyOwcVDcbDmYSHI1a4RS6RGELm9xr4iYpz75cXIF7rnhiR4/Pv/ho0eTzICwvuYIc/lgXBc4QJgDeycbhyVsqblxXHrZwsTxUojVJi19DIlYxR8n/AjzSPjzgL5rwAHC68A8oGreq1NfTHbjWJFNyWrGL15nlPy8aLPkC9y9KkUIi4BKeq23MyarUKPp0WZ+AJvSM9bV/iKKg55ypSEn883FmAlnUliwLWlBEYv6I+e0+9jzQSfPdvqbGd2x3AtMzwlNqoRsYoScLGw8uZov7Lof9AQsEzHRyzKLGoAO3zUU2vz+f+Xb6vaW+2pvyJ5503PbL5IrmG1vylEgRu+C9+hOGojlGpKAGIFKPM2DEXxYrXGVygX+CnIvCvIcclBfsFPpeq//7TQhH/J6fdjBk4L7b0f49l0yl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(86362001)(66446008)(36756003)(316002)(91956017)(76116006)(4326008)(66556008)(66476007)(64756008)(6916009)(478600001)(66946007)(6486002)(8936002)(5660300002)(8676002)(41300700001)(2906002)(71200400001)(38070700005)(186003)(82960400001)(38100700002)(122000001)(26005)(6512007)(6506007)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0J3AsLNH/j7kwtQqh9B0ODvRLzRgaPZp4xzuinN9rOLYoA9JohPEPBfghY?=
 =?iso-8859-1?Q?nbWdrkgWr22QwtIfE+/Gj9wFPLgrLxCZ+AriWlGFyL39bWBIqUnqPXfzVD?=
 =?iso-8859-1?Q?LkTFqZ3D96WbKaXVNMA2z0xidRsxFBd7Mx4lw8zcbz3H2NCYADe0IvgcEh?=
 =?iso-8859-1?Q?2Af+NutyobXsMF/sFeYlNf+ml6L0TT+QCJEcGkvU7pJkxKVk29qXZbAjdL?=
 =?iso-8859-1?Q?qyOB42QE0PLcyfrXgMhk5zv1PDrJeFZfc/ymah2fU4dj1OPXXIAYsZb5CN?=
 =?iso-8859-1?Q?CDe5CSi2QE3mr9+OjThCKFp3O8/4ali447vlsfRrBbFxERQBIxRbvvFjGx?=
 =?iso-8859-1?Q?vtmdCzwn6QAFgS4ozsJvBBgusEPZzVBgo/Z4hGrFkvXgk8cVJwct5A0AJe?=
 =?iso-8859-1?Q?kMLcTdB2NAVaUgCJ4ts7waScALMjVgDPiaD5F+PqborrS4tfL8vcRH/2Zf?=
 =?iso-8859-1?Q?HCvIaHk8W6pWIkLTjKJoQAV+5r2vfQepDWcqjFTOLjAe2li0ROXDSUbdR2?=
 =?iso-8859-1?Q?UrQQDU4cJKtlAvrUpw1cD+7WWTxBpSqpPv9T5idvyo2ODO9vlkfW7GLpTP?=
 =?iso-8859-1?Q?YCEX+E2iYPDV7hD+PHMtp4eIhwpqu1ZJnolB+qnd/zLhJ9mN528aDa6Jby?=
 =?iso-8859-1?Q?7L0Ry1YyAvvdC5AAHUHA7pr8PEamikBql+FYPPs6nVnS+KrmxZrDeWrjbd?=
 =?iso-8859-1?Q?IJXqp33cRnrNjLSMVV5yq35PQPkWKJuTC/CztQpYuuR3ZvJ80ccn87NjET?=
 =?iso-8859-1?Q?JclA2L8hKRKbcrmm+5FIh3lv6rIrup5Ncu5rjKU+6fUmjIegsdl8HBUkJL?=
 =?iso-8859-1?Q?zdsdvnLT3z3RWxRH8R3BID2hfyWCEytkIefxDwHDXvOpFsioaxZy6647up?=
 =?iso-8859-1?Q?dva+73/MYkHXmGq5pjAusEjrkmGD5DRc/q6CWT+5AJv2t8ZVDM/osCu27c?=
 =?iso-8859-1?Q?9HR6X5uib3VTTWG8Lcu+Jj6eB4SXMagQuPpxa1+wD1UX1/wHJ6daBORLAU?=
 =?iso-8859-1?Q?wiNl28zO3V0wH0nHNHcY9xRQGRfJbS5UQIRk3/PbGJSI97owgZbIwYTQcx?=
 =?iso-8859-1?Q?SR3VYL6MAwYreZGtfqRfAgmyB6Vx7+3Y2A/MuvzfKmmVtM4Kt8WqeKIUqj?=
 =?iso-8859-1?Q?CLduvHEjO6x1Re4LqaqPzetxsG5zCL+PuSEuZe9AxDKE38szwtgOce8uDZ?=
 =?iso-8859-1?Q?f6imZwqAounYHlAQRwa5wwVWvyCmehng3qDf3PtgqKP64m8SccWT06saa1?=
 =?iso-8859-1?Q?oZSW2bbidpYMKyDHeN840HLOyAVfhOX/Gy2nfDStYK9K8yy2uyEt8v2lc/?=
 =?iso-8859-1?Q?7g2i1+8UCe8baU+HGtHr4BulbQMcGcSvJqUGuU5IazLB39+IALSZ3moiF6?=
 =?iso-8859-1?Q?axbdHo4TiiktCgjq1wIu8G3TQig9p+9O/YHlURS6dJuJFnw/fpxMprrfKc?=
 =?iso-8859-1?Q?anINK2FzvouGWSdzOjXb+3G6suN4vyhwL7Z09VyXz0qJmTBRhdPTOcmQDb?=
 =?iso-8859-1?Q?GBU0RFvPn4IBVL3PewQ7apwG/sRsh97zKMHKjy1T5hqRjS0MSGuIf80Y4d?=
 =?iso-8859-1?Q?kv3YRLjG+YOuTtpVKDk4awxo57ek4fCfp4JQfntffMaXdkj0PDhNolv7lZ?=
 =?iso-8859-1?Q?00ZSPkVvrk+oVeHuoCL7Rir7iahGJ/gGmD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OTGqwkagvaqVRYyk3w6iQcRl7vaTwmWmwj2g7sUk0CSS0x5uWZ36aeVUNDILpnPZUuaNTu58mUe39tHh9QAefy/JOFEvc0Je82pb6llA6U/xhoqZyXcBQBHC8M9S4J8cpBQD5BceavIGHM+uQxylbX1YdgCCLvdI5s2FJKU3+Zf9v5q5RwxQS0hA7duN9QC/bDlnd97/zFiu8IuTb9V3rYYr+2nPZbUAGiLYNo8a42y1e3xHGk5DLpSuJjMc5rdhD1GW11AemA+E50gadM4oR9RRWTNqkly2S0PGyp92/yojO7b+lQlD29JiK83sNYTA/lMUhhCA1JYtjnjhF9KGN64n5YAlBeVQb9TWsxb+nQ/Gt9qV7vYichJZGoKCfB9ydHS12+6970RNoM6aQyRd619QxgIx33sRve8q3VWOpdyDnD1cvTF+fgT+K7m+WNeFxUl0SlyjaW7iHAlGMoUFa2av/4JV6eehmz99GCqxo143n0QvizKYkoN2q7RS3W6VkIIGCnEcGyh42oYmng1ILz2rR/cF1SFSqjgSsU3kh6GOj8xPF+5Hn06ISHT5DJGVsMaGjgOBChUJInfpyocSq66Gj/KYkw6yAIa8zZa8IjUihaoNbznh5jpyLvJlq0GpQOBoonR4MEMt+oWZmInLHB9CZ4VSQSWyk8EQwaX2WPUHD24oDnRelkC4YVpqHRLUK5uYEu0xReJn4tSgP7Dyw6s2mCdikz7q8d06lolQgqOxOsKU8DZ2grOXsBVOl1wY1XpyacctHM3b6FuCYUsPaw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d880802-5ba8-41a0-8146-08db50119297
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 22:14:20.6969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZYuUZkexMNWgcKIMQUjULp0EXxs+AQhqz3fTY5WzOpXVz0obsCf1x99zSjG3TNfceG8Xbb6tc931EYGm791uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8397
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For data block groups, we zone finish a zone (or, just deactivate it) when
seeing the last IO in btrfs_finish_ordered_io(). That is only called for
IOs using ZONE_APPEND, but we use a regular WRITE command for data
relocation IOs. Detect it and call btrfs_zone_finish_endio() properly.

Fixes: be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4f9ef5ca3856..4e65b2376cf3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3299,6 +3299,9 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_exte=
nt *ordered_extent)
 		btrfs_rewrite_logical_zoned(ordered_extent);
 		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes);
+	} else if (btrfs_is_data_reloc_root(inode->root)) {
+		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
+					ordered_extent->disk_num_bytes);
 	}
=20
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
--=20
2.40.1
