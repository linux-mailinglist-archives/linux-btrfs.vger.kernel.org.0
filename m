Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE5330311F
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 02:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbhAYX6i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 18:58:38 -0500
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:23525
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732081AbhAYTnz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 14:43:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHQU/Y8KNMknxF/iw1RoLN9V0hUo3YP/rbnZN0bYZFXmwgh18P5HEB/FtRFpNtWzyhy66he8AWfKQoTAbcVEGxFsjXzEK0N5CBCDuznmDSVMLe0cEcWDSoYVtBLRhANOBW/3mw4cqj57Mx9VNEUIXqo/soNzhfIXQuAPOmImy+h97spitrrI78O4Vggs9TbaD2r5Mnywiw/ulmNMIpAdvgaazeJhXjaD3E+V5mzPI7kk2oJ+8FwAVWHvUq3x5oYPSgaxnTakZtuqTbnkAIeLIHdivgwvmxfGBdz91wpqp56bOHREcwz4/3iRiJf1BQgARgcI21FAXW2ayxZmwKD5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR22kljIC6t7FuEDHJVejagCLDpNch30HZDv0D+oCaI=;
 b=mbN0kRsyCWIszuFTzMA+UmUIZtH4xQwaLqguB1C5F+7xjeorx+uOD0pK5EHkRuLfpPmUMb3Mrph1lGqVO0BytAqYWFUn+XxdjLj7REnMwG+6qBBtf3y8aGbwrBgq+p0r38gta3lQRSAZ7kC/w5II7/Ldh/r6Ko2eTYAESqT16sIBYOixxXN0cqEPCXVHZV/IywtsWy5BbxPuqJvZG+obVcurQnu4h4i3SOVKPpOA0283aIs8epIol+4OwErQ4Iv4prXKQsHMi6OeWiBsfEsoOAyYuqHGA3Z6psr0OBueimV1e+NXrOK/SWEgPS5kbGiLJQWVq03sEOUMiVVdJGVBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bdsu.de; dmarc=pass action=none header.from=bdsu.de; dkim=pass
 header.d=bdsu.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bdsu.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR22kljIC6t7FuEDHJVejagCLDpNch30HZDv0D+oCaI=;
 b=D2d8nXI9O7dGe3U0T851CN5al9mjW2odsfZxuMMbzz1zEuElvWOjqjz9KzKBBvqCSg+tWT7lqTVFMUUv++/AxiY6URS1L3AlI8C0BAVI3pFP/Pu+rosyzmlcto1FHJ+UogcMsy0Laa7p7UBSsFF44vhJEqla1KQqCJbYyA2Tvuwa9d4f1Mt1kjDw7pGMbHYvBui5nrUGbvJnpTTwQ4YJ7YLNpv+r7COD+1zSF/ul5E/wXh1Eya1OKyUEWkq/rlbf/aY9TLnM/DN8mQ5cqtoUhHYWYnKBek4jdxOLjy39DS0pqWtC799QZbbYkJQvEJZ00IFVznDkU1b4qRV7ipRQBw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=bdsu.de;
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com (2603:10a6:10:17::30)
 by DB8PR03MB5962.eurprd03.prod.outlook.com (2603:10a6:10:e9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 19:42:12 +0000
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d]) by DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d%6]) with mapi id 15.20.3784.016; Mon, 25 Jan 2021
 19:42:12 +0000
From:   Roman Anasal <roman.anasal@bdsu.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Roman Anasal <roman.anasal@bdsu.de>
Subject: [PATCH v2 4/4] btrfs: send: fix invalid commands for inodes in disconnected roots
Date:   Mon, 25 Jan 2021 20:42:10 +0100
Message-Id: <20210125194210.24071-5-roman.anasal@bdsu.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210125194210.24071-1-roman.anasal@bdsu.de>
References: <20210125194210.24071-1-roman.anasal@bdsu.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2001:a61:3aef:4c01:503:a276:cbe0:8dc0]
X-ClientProxiedBy: AM0PR05CA0081.eurprd05.prod.outlook.com
 (2603:10a6:208:136::21) To DB7PR03MB4297.eurprd03.prod.outlook.com
 (2603:10a6:10:17::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nebukadnezar.fritz.box (2001:a61:3aef:4c01:503:a276:cbe0:8dc0) by AM0PR05CA0081.eurprd05.prod.outlook.com (2603:10a6:208:136::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 19:42:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2c18c6e-8702-4cca-688f-08d8c1694f96
X-MS-TrafficTypeDiagnostic: DB8PR03MB5962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR03MB5962736BAB19218D28BBFA5D94BD0@DB8PR03MB5962.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqBkIqG8MU1l2wpUQyv62TZqFCxMhz/Rpb0Quprgnwut1rLUmYoXYAho2HqYF0Qn8TRy5SseRB8cTAJ6AI5X35fvFMtSW56lt50hFw6XwZSLdLr5/xmqBIc9dTiznleiidurEctgFoNy646wEyT0/MoyA1hsJAUArpLL4C1Y+kbGRtdn4qcxg6uH9Xkiyr7F2OV77hJAFNvqMi/1aM8N4f4iizoAQ8kJ9tVRa2tn5WIxiFo2BpnJhEFGeAlOd/h2YT2A6XsPDOVReZ0gKb80L6HDNnppPN9qoCyi25bLy35Jtv0KlsdBcJox6GxTol1fpETsuY19xWpinRPd8Oc2i6J9fm4Np4HD74siX/S+n76bc2Up/XZFkNil6evhx2n9g6/x+EcRkmi7QxVRtwQ0VxYSBFcdooAhLTO2uR7Jf1zN2lCYM/kc1Tni0KUc+ldT8SvjwruR09z1monquyw84Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4297.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39830400003)(396003)(346002)(86362001)(8936002)(2616005)(5660300002)(8676002)(107886003)(66476007)(66946007)(66556008)(83380400001)(52116002)(36756003)(44832011)(1076003)(966005)(16526019)(478600001)(6506007)(2906002)(786003)(316002)(4326008)(6916009)(186003)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?G+bQNkv4JbH1uzkUWN1uVevLb4WSo63OY2F2dIK7Zj2d/aRQbIQxv8g3tumD?=
 =?us-ascii?Q?YJUPbBPuDCB/4KODdPmvr4WWTFZgunwdfQEYwf9jVPOVWq7kuJ+v693yo1eM?=
 =?us-ascii?Q?Zmg9ZHS9eBaSGHqhcgebjI6Qj9bhPT2OxGA4EIpJ1eE2sLpMuFNuxZp1/8V1?=
 =?us-ascii?Q?/52hml28SlGzdMGK2aN/UNRCU96OOisiOLr+a9m4mQyOJMCA1c9+AP3jGKWl?=
 =?us-ascii?Q?lW9F3k8sScafsYZ/XwdBNuS4WwvVYRFlv9bWLGJTz5pEwbPOkhfj0sK0epe2?=
 =?us-ascii?Q?Y9W4fnEiXLPe5iat5jzaoxPDKfSchsi9iAvWO5+FbgMi/vv38Kk/MDVqIxtM?=
 =?us-ascii?Q?dTCtqfSc3t0Q1qqULzCOUfYb9PMRQpoAb2wNXjjOyicSx5uaUefQ79/dlZ/e?=
 =?us-ascii?Q?NvgsIWuRJ1oosarVgJLBdLera75Fjr8cy0qmjDyq+aCl5/AdWQ5oh+biYN8r?=
 =?us-ascii?Q?V5K5SFnZ06HsJxKv98S/lnB/z7QWuMY4EuF7OP8pt74xNsgGfKpVK8kuk9K0?=
 =?us-ascii?Q?8AUOz+9q2PNzRecP3ujI0OuPontoTH2NvqtpjOf/+IgRCvM4VQDNixy2eAKU?=
 =?us-ascii?Q?4onvrOXqU18IjkxBAP4jl4GSGvZ6BE+1S2vFLAz1yxFuo+Qn8+ugtv/dvK7f?=
 =?us-ascii?Q?VOF4wvUrsQwWFea7OGhPQfW1YwWQvM/4QSOrSg1ESfLZbn8YFkAViqYAaxwO?=
 =?us-ascii?Q?b/fUjlAc6VGKZeFCID2rlaroY7JDDF/3IYcsmLEBX04l9omOXTeWxkLKX2Ap?=
 =?us-ascii?Q?VRp6q5bWUjTlNy14m3mz4a81PyCf1yDiByc3OVMNSMPdQ3YdU26yPXei77Lm?=
 =?us-ascii?Q?wJJkirLPyynCXqeAwZlXQE4ocbfL/4eJgAUjheEEwjH0DND6MHypP7hP6ob4?=
 =?us-ascii?Q?1QDfIFqC37okA4W6ScXpcYlt1C59WDeHwS5+xU2R0sUkFBFOh5JSo0nloRfh?=
 =?us-ascii?Q?yXdKUOtrJPukhGgI8fKYQXq1bbABlY0OJlJcHi9RiMFhmmzd7GAfaRG2D8b2?=
 =?us-ascii?Q?jjue3JZ328X5J1Eqlf4DWp4645LyUarAPOiU+s64DiOlCSlbZOJI0mv87dVM?=
 =?us-ascii?Q?Sl+00pfR/yu1t5BTvi7NqKhPKUFskyaNIaEHrzaSSdgHQKclIsiCeC3TqOEY?=
 =?us-ascii?Q?3EpI3VJzn5/i?=
X-OriginatorOrg: bdsu.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c18c6e-8702-4cca-688f-08d8c1694f96
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4297.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 19:42:12.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c0670a1-eeed-4da2-a08a-128fe03f692a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYttLQ6CXTLex38Kv39LqXHQKo0vSq+j5Lgd+vTI2wKjjE76vq+5pekwNSWK44zUoV8Tt0mrvtz3SfX5ytYR1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5962
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When doing an inceremental send using an independently created subvolume
as the send parent compare_refs will falsely report changed refs for
inodes with the same inode number, same generation and same ref name.

This is due to dir_changed returning true if the generations of the
parent directory differ in the subvolume and the send parent. Normally
this situation would cause the parent directory to be recreated and the
contained inodes would need to be moved (e.g. by link/unlink).

In the case of the root directory (ino BTRFS_FIRST_FREE_OBJECTID) though
changed_inode will not try to recreated it since this would produce a
stream trying to remove and recreate the subvolume itself.
For independently created subvolumes the generation will always be
different since create_subvol() commits the transaction after createing
a new subvolume.
By handling this case in dir_changed as well the produced commands are
correct again.

Summarizing the conditions for this:
- inode has same number, type/rdev, ref and generation in subvolume and
  send parent
- ref is a child of the subvolume root directory
- root directory has the same inode number - which is always
  BTRFS_FIRST_FREE_OBJECTID
- root directory has different generation in subvolume and send parent
  which is always true for independent subvolumes, i.e. if they're not
  snapshots (of snapshots) of one another

Example reproducer:
  btrfs subvolume create subvol1
  btrfs subvolume create subvol2
  touch subvol1/a subvol2/a
  btrfs property set subvol1 ro true
  btrfs property set subvol2 ro true
  btrfs send -p subvol1 subvol2 | btrfs receive --dump

The produced tree state here is (starting at gen 6):
  |-- subvol1       (ino 256, gen 6)
  |   `-- a         (ino 257, gen 8)
  |
  `-- subvol2       (ino 256, gen 7)
      `-- a         (ino 257, gen 8)

subvol1/a and subvol2/a are files with the same inode number, generation
and path name. The subvolume root directories have the same inode number
but different generations.

Example output of the receive command:
  At subvol subvol2
  snapshot        ./subvol2                       uuid=e783948d-4fd5-0d47-9777-43036e468170 transid=8 parent_uuid=7b0cefdb-738d-e342-a903-501df1877b01 parent_transid=8
  utimes          ./subvol2/                      atime=2021-01-25T18:07:42+0000 mtime=2021-01-25T18:07:42+0000 ctime=2021-01-25T18:07:42+0000
  link            ./subvol2/a                     dest=a
  unlink          ./subvol2/a
  utimes          ./subvol2/                      atime=2021-01-25T18:07:42+0000 mtime=2021-01-25T18:07:42+0000 ctime=2021-01-25T18:07:42+0000
  utimes          ./subvol2/a                     atime=2021-01-25T18:07:42+0000 mtime=2021-01-25T18:07:42+0000 ctime=2021-01-25T18:07:42+0000

=> the `link` command causes the receiver to fail with:
   ERROR: link a -> a failed: File exists

Signed-off-by: Roman Anasal <roman.anasal@bdsu.de>
---
v2:
  - add this patch based on feedback in
    https://lore.kernel.org/linux-btrfs/9e177865-0408-c321-951e-ce0f3ff33389@gmail.com/
---
 fs/btrfs/send.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ef544525f..3114770be 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6543,6 +6543,15 @@ static int dir_changed(struct send_ctx *sctx, u64 dir)
 	u64 orig_gen, new_gen;
 	int ret;
 
+	/*
+	 * Treat the root dir case special here: changed_inode will never
+	 * produce a stream that tries to delete/rmdir/rename the root dir.
+	 * So we must assume the root always as unchanged here to not produce
+	 * incorrect link/rename commands for contained refs.
+	 */
+	if (dir == BTRFS_FIRST_FREE_OBJECTID)
+		return 0;
+
 	ret = get_inode_info(sctx->send_root, dir, NULL, &new_gen, NULL, NULL,
 			     NULL, NULL);
 	if (ret)
-- 
2.26.2

