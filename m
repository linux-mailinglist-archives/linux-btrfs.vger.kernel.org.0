Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E297D9CB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 17:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjJ0POa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjJ0PO2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 11:14:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CF793;
        Fri, 27 Oct 2023 08:14:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUsYl003236;
        Fri, 27 Oct 2023 15:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=sOX3lgYXhpA/Bxufx0ZIFOYJWEE/GxS02jB0W0cvAKQ=;
 b=SMTx7x0WUKiE9sZ2zyd7yu9D1HSZR32OuzfVQd+/+cNnG+pnftPWeQ47oRpw/crUF/xr
 P2Hx7QYzRqFhGddkfRlXaHdgwW2SQOr1tq7KCve8A3TAwyqWs8seqK2p/9YNOjxD+40S
 GS2iNBlR4cTDskDWdI8UHRZvN/KyEJ6nGn4Iw/ZucE1f32KnshFoJw/K1xW81R+MMsFc
 xWAQTbR3E+ZOJll4nqhOIWT9sclDJ84TYZfppECV4LIbW/BLY9dKWfAsXqbfjIs3MeKQ
 AwQogFsA5b4kXLl7QTW9emMmUVB464ItJgae8LIIORZNEKJegla5/SgIK7aQv2/D8F1d TQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyxmv9ntj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 15:14:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39REtLRD008151;
        Fri, 27 Oct 2023 15:13:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjnm8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 15:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sgrlnb23IFmWsI7lL3ZlIVau1h3B4Q9/EHKk++rerOLpK0LCHXzk2MDJUHyQXesVWhrcoacJMlzx26qEZFlah32POOZjAF0TQA7+1LihaecW7o13gU0RrFr0bN+LlFNS7BWazlHfbZ4ejkKpE8yjBwS1EzavTKlKFlf1ma53ajM3ZUDljDrieDzGglSOIZJUdJDoRU7xGr+eZnUNXRyL1cQTma5p7s+kG/F0nTayJ2s6TGOGacpbQDamqzydZ3Q53NDZyTUH1SN8xE51yqxkg0zekW2Mzn6aHuEpU5xT4VKd0P/0tygcBIjkQj6O1y3tjCqgFN5NhP3fng2Doj5dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOX3lgYXhpA/Bxufx0ZIFOYJWEE/GxS02jB0W0cvAKQ=;
 b=k+xsz12dAZIkJjle9/ZXcNakKZvTjX8V8VcOizavJjYuVNGkapSPabogOu/+6vwk06GuUiehdYPtGpuTzWywUKkYu13Uoz2YZo+2L1e084ThLoOC3goRVgiHOwrDrYilBiwCTy2aR5PHXUa0nppGBrBH78Fw9HIYfRTuJhbS8dmHdcdQJWwTGYFx3xWVheh5HA2MiNLSBb1aXcZVvJZlPqZ9ffqaSffCz/eHcLu5hQ4aw50wJf1c1i/+suhwq7i9YI5uVRxcJYfEytdM9BkKLZSOwE37KY8+ls6dTj0HRKaD/ZkRl/AqlG4y4hnUwqYNbiOiL4xEX7LB8yKjUg54gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOX3lgYXhpA/Bxufx0ZIFOYJWEE/GxS02jB0W0cvAKQ=;
 b=Mm9ZBsPck0w8Eq92pKQLs3zuxntrv43ON+WkmSPiRrRUb2g1sk6aqIDuvXaXieGNuI6NEiKFoxSH99slZWIn+/lbW85fLDSQez3y+bvh+b0u+UshVvravc4KW1fap85mjlJtlUiaUwZropFF8vgYE2EcOSKIEmhr2SjmbzjOeMo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7785.namprd10.prod.outlook.com (2603:10b6:a03:56b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 15:13:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6886.034; Fri, 27 Oct 2023
 15:13:54 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH 0/2 v2] btrfs/219 cloned-device mount capability update
Date:   Fri, 27 Oct 2023 23:13:46 +0800
Message-Id: <cover.1698418886.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:3:17::35) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a11f93f-9969-40a8-3f99-08dbd6ff5555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ciClTykfqLv1lWzRkGqmvRnZrxZGQZXJLLoCnlHLTq6TovYMpZLug+5aA4LjMTMiOAhi0Y9WLNmHC5m7/4ZH3n2EAhpCKLbtZl7bG/bcxybrSlkpcLqJecAxuQruYLE1jDKfDipC39lsMhyY3HqmsTycz9XnEbo2EabwyOJ7BWLuXo1nqOlN2HLRSsQU1ekB33K2QYlgeGB5IV0cO/5d2lJ+Z8TKYKS4w98kir7PMq0+7J/+FwenXRDC2UHpT0LBSi6wp/Cxy0RtYQXTheqlt4VZkebfmd/x+XDNJ2nqlMxvu/ChbzPZUYS1pDHpOwgcLn297Hv9FzmlvKx2Zb6oaarZOE9acgCs1vrwAN+PQnKljKgia/2Yb0/DwofhLd5ZeqLlrJy7GhmNQgx6iwsP1yyQkKYJ7pEJrODsLdhY/2elhFBVJSTLswgBGDQERDtBMxfzV1g9HWZ8g4ExyN5HzkufjISuY+QARnOaciGydbynhMOfz8OntBI5NT3RdozD3Fx2gYw/oW3NQLfLqsfvmfk82X2kM+1e9VSL5jZVGpV2UQ2VY+ke8gkNAsOrixjI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6486002)(86362001)(38100700002)(478600001)(83380400001)(36756003)(6506007)(316002)(6512007)(66556008)(66476007)(6916009)(66946007)(2616005)(26005)(41300700001)(2906002)(6666004)(15650500001)(4744005)(44832011)(4326008)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UvVv1TCnRWOG9zVl8AkHmQeW9FgSgtUQ4cAPXFR5/xWypdlodeAPhUbuW4ir?=
 =?us-ascii?Q?E4oVTWYZK7itbCrgVd3xSk5xCBoEvdjZzXMjfC1ZxqRD6vaCX7D2QKs9pzXz?=
 =?us-ascii?Q?MYUKwZ3wnVnh8koSyaVhXGULXI1tWSsj4vbTUEzQQCzhKfzn9PLsowDekB8C?=
 =?us-ascii?Q?TeNiiP1XdGb4W7TW/J3wiiPmnDDbxPL/PqSSY87Skz6b1Ab2o6YLWhh01r3d?=
 =?us-ascii?Q?WIFPhWna64ZDvwiImVDgNX0W33XDdz4EEkjVcRooOOQl7rzqNzPuQEmv/zyP?=
 =?us-ascii?Q?TSj4fZQLsZRCGYxs2KK/co206ijcWOzZxaZhuEY7tyN8U7QTypta0W2lF4Vd?=
 =?us-ascii?Q?KOrOmM73GPhC+fVXg30B+j3wp8JYmI3Ok5fWnoezwDoZXKXYS1uoXg+O3SKY?=
 =?us-ascii?Q?sjQpk4LHVRYMeajstBX+11pC2+rtvU+4wsG8WIJMeFFNwEUScoNVPJKUBk0r?=
 =?us-ascii?Q?j15l7Td8N5i+3DaynqsGel0cYPckDJw7PX8qEZWD0izSCOTVJgW+ffBVpxfP?=
 =?us-ascii?Q?BuyE3XxAQbGZFw+8MBLXeOaj5BhgdvednmwHpX0WIIqza0H9F1heFXtpnBzo?=
 =?us-ascii?Q?ZVN1oVE/49N1v805H+dJ+Xo/e0LhpAJMK1fAHFO/s9pqakoJND+cRZdFnND4?=
 =?us-ascii?Q?DJfqYaZxV8lPgWmNiLaxGB/wRvRsyD1Q6bpGi1yIjmw7UfPa6olpu/oF582k?=
 =?us-ascii?Q?WV9zUKobdzU/sqTrzmbrzA90VD8nNI1zjhZGisw5/iJYUwy4BhHQz0Huoe4P?=
 =?us-ascii?Q?PTOjI8EDnhuCEMSiZBMZTUTLPjEGB6ESlOcGtk0PBe559qwQoJ0gSNkNXUGl?=
 =?us-ascii?Q?6deanGyXsWblTEmtfaF9BNVjsJ13L0ny20DhuBxTFwfFlIZI3CYgcBpzxAwS?=
 =?us-ascii?Q?L2Z/3L5lsb+MwJArwZ2DMv0smguRNoQqp28/+vpVYaf6+zeIIab6xWK3Vfbs?=
 =?us-ascii?Q?TXk1jUIUGRfIHFvkL5NscHySgsjPmXcMqy7gF7S70JL3Qlb2WZslIlYfzgHg?=
 =?us-ascii?Q?JXjXcoF2XOsi6whNSg3aFcF243Zjp7T64cWzJfwTNZgthLBkl8vZZapeXcQa?=
 =?us-ascii?Q?YyySdNRbGmKGNVVMnYj2FKjNrfry2E4WcCxkojwBDFCibDpohlE7Ld6lVtK2?=
 =?us-ascii?Q?NV/qdkJOZsygAzUNtptSWYR3tp6bzEj/rxMMuXz27NuBW9c1pchRpbtE1cOV?=
 =?us-ascii?Q?LUY5De8tU+yTqlWMCnhF3RNvSujCZjcoiFp+kJcS2/aa4BOIEKXz2Ex0a0lS?=
 =?us-ascii?Q?1He1PHTpvTEwYyw50nEMaX3DQtWJTOQ5GigB6D+XsJIb2JSAviiRBfR4NQVC?=
 =?us-ascii?Q?VNOXrksiB08L1FvfbEH2iRJRTFUIGAo7FGRX3CEMeWBZtX8ypst0SQGvZ2gi?=
 =?us-ascii?Q?2192q/BIJUBRB9s1qFeQLc4J9tW1KjVheX7AavUETu6TkwGouIFFPCDhtyO7?=
 =?us-ascii?Q?jos/me0mLw6UhvZM/AkTm9om1yrSzRynOCjXILs6n26mY8PRB9IdAh2uD0qd?=
 =?us-ascii?Q?FJjxpuDWYjDK0JFtyxjeWH5Tm6j7Gn+byHc/DhF40qc/e0FduCjth1KYyDLd?=
 =?us-ascii?Q?EfJxBLCh8GMxMsIjjA9RsGSF3sP5usMKl5/T4Jfe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qbS+5xMFK3pwoMn14Tll9wIwe4/0M7qJnEWzhVQSW67DmaTjy76B8KedU/GlYxUXcegH86h5LhFPpYHNrBZpBcVRkaGukJFR5F1eJ4B0s8oak/KYIihkDrmsC16DgjVKYlXpuV8poUa3MNHf+IY+JTCox0fVjXI3xZC0jsRv9ShxiZuZKJo14GZEiLc35+dUZYH31iYAL80j4X5TlGlELdo4YffoAGcCjcDNS+XT7F6R3uHNsFDvASzhpN8nwoX8ZyObHGy5ReOE/BpROXwmDtuVga6TB4dMZLvbau5sfkwmzQY0vc9ZEl7VxZKZfBVcy4KxrkZHTjpV8hIxKjYo1C7QrsqlgLJPhgEJ2zosQkDucqBOsB8Cra+uIfTubpaXMO1oHXy3aQlFdEQMhsfUsClsjaFbt3Skh6kr3GneozCZjYEQnrFTvnznkb9XNimvzGpykKlx8FKAXy4/uzD8l3Uj8hxwOaDz3v4cJgEgNmfsy+SQHcKHBzOjRy+wewdJylyF8fBP7r5VszZ1Qrpe9TuHLtmRNf7WP9q8MrCgwEyIhMYR4pYNeLO4hLp5SeUEKRR5XTauhYmtJRJhm2+O/TBYVtb4JomB/thPrhpktC5JcvxNdz7xw8VoS2PBe23VNySO0P2xV0NAROFkb79UWifZ35+Pe5825396TrEWeFfZFwjqkoPiflf7pPwPHgBx0GxF1qdnzSHN7GCkkiQQcleC4I53/CpqUqd1nKg+o9f1Ch2zAODXsqv2EsnwDWXtGKwAs8h5E0zMyNldtpSGYWKPgBrRmLRaRO5+xOhF08c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a11f93f-9969-40a8-3f99-08dbd6ff5555
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 15:13:54.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azCkOM0OTmywOGSSNbp3nfzTFVbJdhy8gYZt6eAdo3CNBCKSBo7oxXoE4YWZwPaO4pj8QqlHiiQ+/FxWzilCkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=797 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270131
X-Proofpoint-GUID: QOqorkfHkb5JdAHPTM0QhAIuBswY-Dcn
X-Proofpoint-ORIG-GUID: QOqorkfHkb5JdAHPTM0QhAIuBswY-Dcn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2:
Patch 1/2 has been added, which performs the cleanup of the local
variables and the _clean_up() function. Patch 2/2 in v2 restores
the code where it tests clone-device that it does not mount if the
temp-fsid feature is not present in the kernel.

Anand Jain (2):
  common/rc: _fs_sysfs_dname fetch fsid using btrfs tool
  fstests: btrfs/219 cloned-device mount capability update

 common/rc       |  4 ++-
 tests/btrfs/219 | 79 ++++++++++++++++++++++++++++++-------------------
 2 files changed, 52 insertions(+), 31 deletions(-)

-- 
2.39.3

