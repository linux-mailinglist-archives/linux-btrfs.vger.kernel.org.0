Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42933030A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 00:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbhAYToW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 14:44:22 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:62438
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731325AbhAYTms (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 14:42:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4HHOup9p8AZUpDLRs3kk/Hem9+eWbzSwIUXc2Sjd5Akb2OYMTyneIC3Ml0zS4ac6JosurE2IQCA8IU2rNbnowzy0shHWF9L3AoNvj+HPJE74UwGgSiBQ3T8AVOC4yBnDL9/eBr5wOvJp+tSNJJIR//JrDVwRZCJgwcevbxqe/u+/Hunoah1PiL34cNFjiKjr3UL7mhx2ptmKxxLOomwAStWe7rrZfS5tkYsJ0qHkZ8+24BH15oFFP4bhNIfX4+vQQa3FPoKY/DgWjLUkdYvmnXz0khGVn0CwbIdBNmmoADsWBfmKeLjOnuSVz9HdtyjG/ZwXzhf2Mtrv5Vbzc7Zfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkahoXONKg3r2p4zp0wNCDcNTPSYkEpePA1W3ZKEnHE=;
 b=DY20e5nNwui/NgKs8ICpHFcLD8Kv3RtTSeEReqvQ9PfuYY/2npS1POzYh/tdqFaDbLdMxtdylACSxnxsoF4SwvG6pH6gxcTQiaMfKVJXIUKSrf0Zl2jPlCADtG50RWWNyhjWyOzx0rWz8536slYqwmQBuamOn4ELL3rwc8kpZeGtiQOrEKRmcrFhEs8/UeOob0LRLAKhtf1/N9pj11NvravLFxDvIV65qIi98GfrJccqozm8tlebhuYYqEFUTBwMrc5hciFweYR8dGy1BrpttchZBWnz1rU3+BlnwFVDfx6aE8nlZRSR0pD5e9+HUKB/Wrpo3HgcuZTcH7fZrdmhCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bdsu.de; dmarc=pass action=none header.from=bdsu.de; dkim=pass
 header.d=bdsu.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bdsu.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkahoXONKg3r2p4zp0wNCDcNTPSYkEpePA1W3ZKEnHE=;
 b=MxumLz18gUeoRsZDxm7Rj05jt1vmFUXud6zmb3pvEpR1z+EdCayT/Xi/xSBOdSVlsmM7o5Zti1NE2giSwG8CGMCCrpyVopVKlFaLedn50aol+gub7RiUetcdwOxBpXpWB/2c91RD0Io8557p2/V84vesMIH1JmelgLDVlA7OLAO+yZGxhWRuE5P1TtYHfohvu7TcvPXhrRBTyst8NpPtJxfL8Z9TJH4luS9rFc2damxblaL8TT0Nwy0uq7KbBq0arRFxSDyMWDY0fjhOeFotnXsm4BnOEJpXs5AX8TYXks4iYLw0+NtewcVNc4+R6BoVcaZ7FdRkx1uzIUtRrubhcg==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=bdsu.de;
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com (2603:10a6:10:17::30)
 by DB8PR03MB5962.eurprd03.prod.outlook.com (2603:10a6:10:e9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 19:41:57 +0000
Received: from DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d]) by DB7PR03MB4297.eurprd03.prod.outlook.com
 ([fe80::b53d:bd77:c4ae:93d%6]) with mapi id 15.20.3784.016; Mon, 25 Jan 2021
 19:41:57 +0000
From:   Roman Anasal <roman.anasal@bdsu.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Roman Anasal <roman.anasal@bdsu.de>
Subject: [PATCH v2 0/4] btrfs: send: correctly recreate changed inodes
Date:   Mon, 25 Jan 2021 20:42:06 +0100
Message-Id: <20210125194210.24071-1-roman.anasal@bdsu.de>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2001:a61:3aef:4c01:503:a276:cbe0:8dc0]
X-ClientProxiedBy: AM0PR05CA0081.eurprd05.prod.outlook.com
 (2603:10a6:208:136::21) To DB7PR03MB4297.eurprd03.prod.outlook.com
 (2603:10a6:10:17::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nebukadnezar.fritz.box (2001:a61:3aef:4c01:503:a276:cbe0:8dc0) by AM0PR05CA0081.eurprd05.prod.outlook.com (2603:10a6:208:136::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 19:41:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f78d203c-e72d-4217-b12b-08d8c169464d
X-MS-TrafficTypeDiagnostic: DB8PR03MB5962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR03MB5962A0E4DD32851DFF1BD55094BD0@DB8PR03MB5962.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdJLKj7F+2xTzcOZhvmN7JvuqQaOZw0nbzlzyL3z4JZiPdvIgFePqQQDCt42P9E/Bj/jFU/GME3KFa8opqce6hrE9xQQwV1dr+aed+EEQoA41tCpYq0pjIW3g98TOQmGop4td9sS0aGOH9fP+/R50AB5GRqLnXGNH+z+jQULZVYYbBVDnbOo+IMGBW231Sg+31o/3totM3vztyL2I7WGmyZqUWSAuQyWmd54R8G4tAlfEX7Aq2/ijBo0oVwWkhWvdr15tbukCbwR1yhQRqchugK9PaNK7wcJWOilZldIl9ol7xUSgXrQBVDbjXkln+GPsogDZgl0vv/wyrL69bi2Y0yraaxTzdABeFWfMcn2hRnAtMzZb6BmMGh/W0JDudsSaPXm0hSvjRcuO4Ig67SS14FDvQJ7gNF5nmRr68+0c30q6z53bFsZAN6OrutKXx8yl509ZW3n2lEBPUx4fXUrXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4297.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39830400003)(396003)(346002)(86362001)(8936002)(2616005)(5660300002)(8676002)(107886003)(66476007)(66946007)(66556008)(6666004)(83380400001)(52116002)(36756003)(44832011)(1076003)(966005)(16526019)(478600001)(6506007)(2906002)(786003)(316002)(4326008)(6916009)(186003)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BRD/pH2YTDIDyNZtCYRZhXgBBLg/JOKjYdxQwDM9OnzQAfG/Q1mvT08EZOyV?=
 =?us-ascii?Q?6CLYZb5CFzuDm5iaMtF7s3uh1ACiWwyKsFd5eeCIXPVvk9jFIV40JKliG5ah?=
 =?us-ascii?Q?yAWue5z7pHNQgdEo6pi+CJKKQmkRlWTY65ObEY9QNde8ixHOzzzEmiZho9gD?=
 =?us-ascii?Q?gNHwNGh6hQ86hVq/PPnPLoTG55fEhAb5DMnaswRfGwMOv45HxrBYemMsPIKD?=
 =?us-ascii?Q?RmzqUVZqI0xbwGQqksFByXli0farK5rS0jebpEd8BUfxsHFGZ2HjfMmy0l+l?=
 =?us-ascii?Q?k/F+bjNG0Do8CiPEq13+7iIFmz6aSlEhPp1+dg4YLT8W12n+nByYuWHHjqgF?=
 =?us-ascii?Q?IAoXR1balwYF4QlByuxBJFHRldL6+quetCWckV+oR2xwdiHDqP05xJ8QhOAR?=
 =?us-ascii?Q?nR2ftZSPFwXAf+P3LDFMb+XmqJa+pO9pEcxoQfEMIbm+QXqQr3z4PtOgZGgE?=
 =?us-ascii?Q?Dx90jXnctudqWvVQok/MGu+txyR6N2LwGprQA5Gd9ki1thLKKuAHlOkY24qv?=
 =?us-ascii?Q?vSqBQ9oaIxCo75H+1a8y9IdaI1Pvlj6sylGQsVA/OICTwN+k3PHSfk5h+F5Y?=
 =?us-ascii?Q?S6fVsg+/fRDZAwRODtV/4x/2BaVOt2RYEpeI6H+RSONOde7i+CiE9wX2M3og?=
 =?us-ascii?Q?5b7pkIPq2qd2BFlvY/YG7V7ol/QUvB4dKM0o4sdP5/xUKJaSb27YXOoLGpyk?=
 =?us-ascii?Q?U1F4ZLCDFP1Zomf18hhcCS1ZlPzXSYvKjZ01+6StlnEzlGvUQxld4rlol7Yk?=
 =?us-ascii?Q?i//oa1KbZiKOHtKUkC4EGWbKe1zaUjO8mhwMgT+UlbS4I2U/5FsVJDwjCVxk?=
 =?us-ascii?Q?nOmdAOTIGomDKptT7DsGvV+jZoaQ5T49DcUWDSDU/vTLZn5fhgbsEuNpYUzY?=
 =?us-ascii?Q?KlYi38VCMnqo3q/7rNHyq8q3t/Y9rr5sh+gdX5Dtjw9YkNquHsuzLEnClG6D?=
 =?us-ascii?Q?FTk5q3pBDbMrUQbo2BvdGKVMlIF1i5lD6M5hQgr+p0wcvhWp62LgsUe7GJUF?=
 =?us-ascii?Q?62A9UXWhqAlL1tcK+rHKTF27z0OXO5B/nE2gqs82XAORqOlVYx9Uza5RG/Pi?=
 =?us-ascii?Q?qzmm0eMYV9Op4TWiEjTRJS6HAJMJN20FVvFahcqhEgoOTg8jsjn1cUNJKQAR?=
 =?us-ascii?Q?skydTeCnHhrQ?=
X-OriginatorOrg: bdsu.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f78d203c-e72d-4217-b12b-08d8c169464d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4297.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 19:41:57.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c0670a1-eeed-4da2-a08a-128fe03f692a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMw0mQ4/zdcR8XMH3vaVyfji1NIDYwAhFV9p/Hj9sgD1nKg8Ve7fAiYkZ0crWu4txTMHBdEo6/uREiFgntUxmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5962
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is v2 of the patch set submitted in [1]. Changes in the patch set:
- fixed mixed code/declarations according to feedback
- add patch to also handle the case of differing rdev with same gen
- add patch to fix invalid commands when using disconnected roots, see [2]

[1] https://lore.kernel.org/linux-btrfs/20210111190243.4152-1-roman.anasal@bdsu.de/
[2] https://lore.kernel.org/linux-btrfs/424d62853024d8b0bc5ca03206eeca35be6014a2.camel@bdsu.de/


TL;DR: the patches address issues arising only in edge cases when snapshots
used for incremental send are not stricly based off of a single writable
parent, i.e. when
- the subvolumes do not share a common anchestor
- the subvolumes are (based off of) snapshots that were modified within the
  same transaction after they were created

Outside of these cases it is safe to assume that an inode will only need to
be recreated if the generation changed - which happens when the inode was
deleted and a new inode reused the same inode number - because creating a
snapshot forces a transaction commit.

But in the above cases it is possible that inodes that are created within
same transaction in both subvolumes end up having the same inode number as
well as same generation. These would the produce invalid commands streams
that cause the receiver to fail or produce incorrect results.


I am aware that these edge cases lie clearly outside the expected use case
which is sending only related subvolumes incrementally. The reason I updated
the patches anyway was that I felt challenged by this and wanted to get some
programming/debugging practice with the kernel and get a deeper
understanding of btrfs.

I tried as good as I could to limit any effects of the patches to the
particluar cases I discovered and am fairly confident that they won't affect
the behavior in other cases - but of course am open to be correct here
by the far more experienced eyes on this.
But even if the patches will be rejected because the issues can only occur
in unsupported use of btrfs send/receive I wanted to document my findings
here; maybe they can still be picked up later.

In any case I'd appreciate any feedback and the code/patches themselves
since it's my first contribution (attempt) to the kernel (=


Roman Anasal (4):
  btrfs: send: rename send_ctx.cur_inode_new_gen to cur_inode_recreated
  btrfs: send: fix invalid commands for inodes with changed type but
    same gen
  btrfs: send: fix invalid commands for inodes with changed rdev but
    same gen
  btrfs: send: fix invalid commands for inodes in disconnected roots

 fs/btrfs/send.c | 69 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 24 deletions(-)

-- 
2.26.2

