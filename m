Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88693FC073
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 03:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbhHaBXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 21:23:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4778 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239138AbhHaBXS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 21:23:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17ULxEPB004150;
        Tue, 31 Aug 2021 01:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=dAQpi1RozQYYQBFHdYX4FdHOd4OnKY2JHQIygZrIh5U=;
 b=lu6pS8lUKHJAIcK9dMyvtoTxVwedcygmfK3ksXzG62zRL5ZEDaA8Rmh+hOYFe1Fdqu3u
 Jj/ftQZHAIB3qy23vzg1KcloUsxI34lecNvU6HKLTrRwPkez55iLiWAu4ffLYhuMW2Hw
 mm+AqI+sD5cy/WzUtkiQzXKq+WhwfVZS2NriiDgO+9goRUJyNO2qNoxRQli+gpPXxAOm
 CD5QaIse12qE20Z8Jh1nqAKTnoOGiMhMmzPL4uUJGmtM2IsQAHN7gB7Rb4/rv45EaaPO
 DBmSjolbPUlKuRirO8hhtJ+8RZIrs/lTItJsI7mBEnJ3XJXcmdBMJ5mVdlC+cAFnPnPg 8w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=dAQpi1RozQYYQBFHdYX4FdHOd4OnKY2JHQIygZrIh5U=;
 b=GmgEQnjm+wCTWsGXbRQs+U1ghr0SZszY1rsXr0RsS26FSenff+kUpNXD7vpkzYu3BM+O
 iRjb+i4D+tMBc27Ms8NjU3qPIRxiaAN1VAkVoVOhSlR0+SpJnfBX7l52/7DAlass5ZdU
 vv1ZDS/lUkIy5Vc367UECMHMr7RH0RPH/zOlpnGdwFZNLPU3LnbKRiSpCPyIwNfDywA+
 BBvPPzN4j0ipQk+pYSb6SfWcojF6VyDIJrFDLOyfT6jKsQVRAfNqydH09OPVtHnO8cwr
 iEc/AsPjZg/dls/cfo3N2X4eqyWyF//qucfmNa7BoQ3BcdEvcE95p6Hkb+br5Vl0knDg /Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arbymjwb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 01:22:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17V1Fb6r029753;
        Tue, 31 Aug 2021 01:22:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 3aqcy3ssgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 01:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxKc5hmGFULBunK4vZMlHCzKpFUEdvwrRe5aM1LppvgPVYBhAh415Vpin89Zt9S1e3zNz0+q/+5Xe7USA+VEj9pOfsybHzF2pSDdYQN69QFMgnpTMk5laLu7+SYHbQBgUQxodFEGpWwXeXsKH+g6y5LbR2dotdj0kIowwx5HX16ZR6GKQE26vdpqsbrq96EXXBm/N7bOK691Fw12QC+od+lfrtWX0iwBSR5ZXPH6iwatEhDGxcfupQfRwW9Y8q0c1Uy7M0ZJxON3bs8u0oqcV0tGSUN/sxKtlBFBW+h3XOWOdMQRz7efmpAEtKYBxLnoHC93BtQh9gsa0mP1p/JrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAQpi1RozQYYQBFHdYX4FdHOd4OnKY2JHQIygZrIh5U=;
 b=gmfAVfiCvLHSf4lwXi8vl70C8SPWJ6w2dqekelEwarXJENAuhoXHiPtDlVO6L1K3DVjPsaxNbE/g8Svcf30YKwfVV7Kn3xuX4brplsJV4/mWwh8VVshBcHoOpvC9ILlmmLsxu86u5G4qgM1ocyXnwC2PMF2GXdkT4n00XoAOp8McC+qz87cC1+IoYMe9USjPTVB0z141Eze0Uj5jEOdgdE/y3feS1S/ATIz3EXXVn7qQ6NLXcNqQDVQPaRxPwTaAv6sT245zzXQiRGS8XewhUckt6Xu5HqoGZI0Xw+LJvhGvjKae3ARrmI18+qmX7HM5T2LpXWvQAp+V09hs4IvfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAQpi1RozQYYQBFHdYX4FdHOd4OnKY2JHQIygZrIh5U=;
 b=Dl87fB8WAQsbd1+8OU+5viKLEtPH4Ib8d3kRgEC+Qa0u/5ukexL2dZGVn/RB+kQEK7caOQsgrWzKwQVZBMiOPilJu65CLW2DcraWxU0chwrBuPqa5mCyqhnM5d0mdvAD2O83Gfaofb74wJ50Y1OqgWqb/It3WQxnPY4qxdoyLL0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4334.namprd10.prod.outlook.com (2603:10b6:208:1d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 01:22:12 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Tue, 31 Aug 2021
 01:22:12 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     l@damenly.su
Subject: [PATCH V5 0/2] btrfs: device_list_mutex fix lockdep warn and cleanup
Date:   Tue, 31 Aug 2021 09:21:27 +0800
Message-Id: <cover.1630370459.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0144.apcprd03.prod.outlook.com
 (2603:1096:4:c8::17) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dev.sg.oracle.com (203.116.164.13) by SG2PR03CA0144.apcprd03.prod.outlook.com (2603:1096:4:c8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Tue, 31 Aug 2021 01:22:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 602ce6a1-e90b-441b-340d-08d96c1dc266
X-MS-TrafficTypeDiagnostic: MN2PR10MB4334:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4334E3E507B98CA5D2AF0DFAE5CC9@MN2PR10MB4334.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEwiXg+rnz8pJhlLPZD46mXm+zjnCcgP5wGzHILEJLpr7aNu5sF7sceTK/DlNQ4UKxqnHQGr7a34Y5dJPL7dzr21MdFl/OOJPvoEZiXFvUisTlpFS4zaIAytoS+7WZgHGqm9j3vzdD/H6K9lRqtUhhZkLj4QxhXepLe27FUCCqjqTe7kBoddodgvnK2VCEXJAVOYURylHtj/HPXEYkp/nJMx5oDZHxNbNHozEJTntguLwg7eadddhiTOu5rfZb6ndRFmbeI6IL+X/8PqedvaVNR2v0aexMLzYi11f4epuDOPtdvcs9/Ktszp0lZsOjX++TWrgLIit84eVG1M4gdNYTRg0UosTT0sq2pGxU8skYe4msXTy+g3NrhbRkuRjnM/AsfSaattDCbu0JgkQCHtxPDAGcgEzxLhu6pYDyCefA5ZGB+BPT7HZ8ek2Uo3JlDk3cUEuL66pyVaT4t7x3QCD2mD7DZc9jVaRD81ZwmREd47O5H70aEVlUKYvgjeXwvqGilx/DWdabIQMcc8gd2HnfDJKXA5/x976rgRkmy8q+yG9fJy3yg6KHeVAYQt8iK0q/0oeaKQKIGrpw5+WzWHvvtRbLzUW6NIX4wN3Fan2GH9i+fMHpOxfjsoS/CT50GoRN9z4QoxDO1Yt8XUZ6xZP7NmedgKnHIXXT+5cI1C0thM4NNu4tW9cRTODjHQpz94
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(5660300002)(26005)(7696005)(83380400001)(4744005)(38100700002)(52116002)(316002)(38350700002)(4326008)(2906002)(8676002)(86362001)(508600001)(44832011)(66476007)(186003)(6666004)(66946007)(956004)(2616005)(66556008)(8936002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kPeAMzOMI0I/EQaO2H0mQ5aALaSqhJBe+jj6k79R6uCjYfWF6DFTNI1R5rfz?=
 =?us-ascii?Q?DQN/SpSFgC310OYtuiNDIIZwA/bfXttClL8/GgRWp5k7BJCF595Pjsen3bjh?=
 =?us-ascii?Q?ZIvyTDMLHhL/5/HwcWqcKWwDdqbdtL2WDeNzHE8IMVmFicM0kn8Zq0GQta1x?=
 =?us-ascii?Q?wgxCZouM3iAjI0qI28lwAzEaETLJUjmimP9d0vLkdUw0uc92uJWDzWHNvKsL?=
 =?us-ascii?Q?hqmFjO1Rm29UQVds2aCkJxlvDauzdgU9Giplkqxqyy7U8cG5Tv7CszSbGA0x?=
 =?us-ascii?Q?mzoWjnwEsSjCiXYu6cqHjoUGkDYA/RRRQ27hb1Tmicc010Ou3mpSYe5HNSfy?=
 =?us-ascii?Q?dPYSx22yicl3n9JRzjXRtMl7gE+gZLwSmkqYpBMeddBMQhfs9Jv41W6wvfy8?=
 =?us-ascii?Q?F062qbHnVAj8C4cr2zTiiksmdiqeFWIV0eWeHRn4EY+zo8R+o1EHG+hsmzLF?=
 =?us-ascii?Q?D09dX5f5EVkCv+++O7LBCMJIRP90MJ7qjUdYmHv10AKdl70VDYgpTi9/J5d+?=
 =?us-ascii?Q?Nhsa/o1Nb1N2sakKNTLKjJQnrc/KZVM2eTdfO8pnBwbXtWebNXtKa5kLdFcp?=
 =?us-ascii?Q?q0Waaru/R921J6xGlL9eL23SPu6nVMx8pSh7T93mWETOjdYtQYt5M2fDnovS?=
 =?us-ascii?Q?JI6PJaf4q4ju4RprQd8J/wJwJWjl17YS6WyJA7/BnXuiuYMegJKcp+lXXxv/?=
 =?us-ascii?Q?m8IDrO4bL0vsaLI1WNbZ7TE5ZEe0D02c3T1T5CWX4o9fVc3EyHwMvDEJCVhD?=
 =?us-ascii?Q?c24MEpJJe4SUXmlEDNQFQmhJM4uYkbGn5w/dhmNQSdbqYPqvn9s9Gq1Oi3E/?=
 =?us-ascii?Q?2pE/RGp+m/ppqbG7fhN01KZ81th4p0/Nz9DCkUO3iYcYPjpaE9GPj4G5sJ/c?=
 =?us-ascii?Q?0TrXvJ9g1JCnuJukqZoFMv/rB3nj6i6J2lMGxTpcy++f109KS9+wgAZimgp1?=
 =?us-ascii?Q?PWJts8K3/37eGuYBqHZDw4u5VppLZzSypqIcAL3UyfUlpZ8G08rrIRM5RL1V?=
 =?us-ascii?Q?bJ7gwXq8ue/BCZtc54VxuaCyvInYFAuFsd2B8WvsDvAm08iEjtZ3hI02LwbR?=
 =?us-ascii?Q?K+vVPlJ3MArGJBhZO27qpAYWwhoYVIz4ab8gx1Nx790ZbFfv33fVNB2Lg+qd?=
 =?us-ascii?Q?RdAQkNQxb4R0e2es+LSqZ2ddvjUN44LYCl4nPXRvxvHEEo+4xNanPrCgsdWy?=
 =?us-ascii?Q?3DmTleUur2PHB8+F9t7kr5oZ9pJUJENOdZtGmdaILLqIpmejVz3w5VUDh0DH?=
 =?us-ascii?Q?qi1R1iBcz4GZFl2r9+QLZw6O+IGKVgOPzYQQjPe9T2/QVNaLeAGxtjroWzLi?=
 =?us-ascii?Q?DupiBE2CLSFse9bd4hbsFNkZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602ce6a1-e90b-441b-340d-08d96c1dc266
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 01:22:12.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPgtXVLjNrfh4z77A4/HkiX1PuRmJJMHbO+UDWXjWi752T55e/6omqWq8VjR1AgN2jxaxDIgUG2cn2QFals6kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4334
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310006
X-Proofpoint-ORIG-GUID: w4vxqx5eu6kHdn2sly9CZV9zYPOrGdD7
X-Proofpoint-GUID: w4vxqx5eu6kHdn2sly9CZV9zYPOrGdD7
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are no new patches here. These patches were once independent and or
part of another set in the mainline list. But now, as these two patches
are related, so they are brought together in this set.

These two patches were at V2 and V4 (respectively) at their last reroll.
Here I have marked them both to be at V5 to avoid any confusion. But
there is no code change.

Patch 1/2 is an old patch in the mailing list, now part of this set as a
new cleanup patch 2/2 depends on it.

Patch 2/2 was sent before as part of the patchset (btrf_show_devname
related fixes). And, now in this set as it depends on 1/2.

Anand Jain (2):
  btrfs: fix lockdep warning while mounting sprout fs
  btrfs: consolidate device_list_mutex in prepare_sprout to its parent

 fs/btrfs/volumes.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.31.1

