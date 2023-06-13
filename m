Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2A72E012
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbjFMKtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbjFMKs6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:48:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C171AD
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:48:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65OJw029894
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=Sei11RH3E4uZvchkXwIZj70fH87Wge+0QwDc4uo9u48=;
 b=AwJr24x58jB/TM0XB+f/rBu6dJwm/lR/gOb1FH0T6o7iGNnWv7ekTIPQpo/INMc6VMwf
 P8RYUfdjI9oHcaVxYtaXGWqU7bEwTuDo+uGv5do3yJFHTbCv98qVu/fZMG57cVakkuF3
 5Pgn5ScuqF9dkqGyyWJ+9JllmRYyXszk1p6oDqoWn5NaWegbfgilqk8Xp4U/6oymlXk0
 FxOPhhiWWI3S4vHuaM/kPAADllstYzgdfs11gUED9ockpNtGsgTt0jXnbpyQHTy+qRvl
 4+NgGH5bJNGTp6L4qC4+gbZ46BZ2oxutVIFV3b64V4+aiD8bC9PmSr9G3WopuInP6UrZ ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1w0qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:48:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35D8vj2O016225
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:48:55 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm40d47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DukdNHHs09AH9GVfjElgy4Wqe6nz/YeG+0hWX+W4iDc0Rb5pEEF2hqQyEsRAfAhW1dKwyhbEER6O7PDzJ5Ou7GCWfnhGzT1c3AOaUbnugYkvJtrvUuiYFuiOJyZX+FdMDKKBi02hE53nFftKffftrpm1jH1XOcqFjbZp+T23IaJzqCBFUw664g+KhA1iDJYqyWjScE6KK5T+MJT297R4RH4lF/A9e+nsG00djsQst8MEAvYiylhqddczD+MoN034AaPaPTT4eadi4nzCcbkWN35mnJ7mtfIwRf61/YcHffv0XYonLS8ScaYw7P3Qx0cLuTsRGYiPNDi+2eDBY+zkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sei11RH3E4uZvchkXwIZj70fH87Wge+0QwDc4uo9u48=;
 b=Q2xmAf/oPcj+gaUitsxG7U33fGlZ7lEnTnNAx7QgXdU3MeK43peEkppqG4/vU19FsfiJeiPFVAA2nyE2PyuLL4Ks/kH/rcj+IpUys+njO1cCL0v+Pc3rfFSFfAvunb78hp1/EiBbBPsJDCrQ22b6L9Pxenw1CZunr6/uobbfVmLxWUIlYfArd2lhGLasaYM5knUOMTM/hMzKuJcqTTZJ4sdjsvBsrw6I1mQ0SRkKg3OfuF69v94tB5GEMNokNvK4JmJGDbUClayNlmTxL2eauK7OEyUEO2L3UkDiEHSXgSqR4kWwlmka6q7THonSAA1ihDMhhfvqtHYYEbNsgRTCJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sei11RH3E4uZvchkXwIZj70fH87Wge+0QwDc4uo9u48=;
 b=rLanURfMZ+io95KORLTG52q3T7cb8ntjpWIbazyKzRz9sOfjKNdYn7gd4km3Q+io8cx5H3CPH2yyqkCYmPE9AN0Ix1SPG2RgbHl7lckLxaXmf6TE9PyArUGgDGUNbCTOX1TcLLX9pnWKA8TW97clmEuHJeaSS5TZs2jwKKjCOcE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Tue, 13 Jun
 2023 10:47:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:47:53 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs-progs: tune: introduce --noscan option
Date:   Tue, 13 Jun 2023 18:47:14 +0800
Message-Id: <cb4864eecf9a5d3a5bb8a2f2c2d2af3f84e4c7ce.1686484243.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686484243.git.anand.jain@oracle.com>
References: <cover.1686484243.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:3:18::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba58e54-23e6-4580-7e21-08db6bfba3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJBbbhqV45VDtoF7MofedNYvILDjmH7vEUCnxQwEIALujclFs5mpoxhvrMSwuY3HXf0Hu0s8f3qgyFUvP6BvTEWEnvzxAQMjvdaB3odVpRdAGOAL1Ff0BRi5QR3vP+Tav/sNUp91sqoEaXcp8g2atIkL0qkSu9KsLgaLWn1/Q0Llp0mvEqLA3+8M01IXN7dvp+zRXGhoD+2b2glwpjEUBR/SeYNy/RbVdxhSInLl5NpNIloxoT26ndjbIaKxC1e94YMRWYZYoK0LE4WMZQqQxp0/gT1hHaV3OFrTPHwBthK2MJjIxJ3L5zkb3Xz7jXYTOzVwq1NSTLMtNb4VB86H18Y+rIbEhYrzGWZOAeGpBzfL+pne9TZHsFA6nbQ/4tWrehhHqdnFQK5vGUVBfnnBV/hzZ0SHGbiA/Bx6GfO3nyqW2jA50zpyanLH1QUNQetaISkI9gTRmyW3TsDIayxpnsrElZRwoAHiZVNdv0ZPxr+zpaI6pqyZTOWS/eI6YrebFONENwScl5S1lRrdJwAyJEbcSozZd7wgWYMtrWP+si1F6DlLxqGnmCBYebeQUWPynFi7RI0wFXxiNJgyS4K1cWY7i2nUtkKqsSe7r9E+W8LO7Ve6ILmbCOAh86AKAgzR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(86362001)(2906002)(2616005)(83380400001)(26005)(186003)(6506007)(6512007)(478600001)(38100700002)(6486002)(6666004)(41300700001)(8676002)(5660300002)(8936002)(66946007)(66476007)(66556008)(36756003)(316002)(6916009)(44832011)(461764006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rb6Qv6PILvj7HNDy2asu+VbZa9sNTAx4t3VJ/I+uG3qyEMEebOjm5NU1R4iA?=
 =?us-ascii?Q?iuP9PZB5oIbS72Trjy1f5eAAO30vsmtL7a2qUQIDo7uWWjawWVYshUieEcm+?=
 =?us-ascii?Q?HT0uyaS6jVSgNzCOj2iJmi4UqPlOua7dBO7Ar1tE5rZhtWHHI80GAcYC9ewC?=
 =?us-ascii?Q?WaODL4bOYEkHSx9P8Uoh6D/VZReAiteC68NBb5LoZpADr/DBrbR+HeF44Fii?=
 =?us-ascii?Q?a3S3gamelAdJL4BvGhv0vEgOHK+J96EJSWx3tZq1n8nE4DxAe7/WFMU0snVa?=
 =?us-ascii?Q?GK7SwskuyIHGm5ZKz0O5tkYimTaXUSpE506qSEzaYcTdhYLcrtcf520wNMCj?=
 =?us-ascii?Q?xfaROoQ09lNU+XAvlMDZYb+ktA4e4bcgdkxb8gQF0Ww5uc0pfi/07OMLT3E4?=
 =?us-ascii?Q?kHfFYoimAzNrLqdCMxYNgR0WP9lSzlfWEiMUQ6MVI/5IrmtWt6CmWe7DlhwT?=
 =?us-ascii?Q?gq1/Az4aRuNWhz/6bIqNnjPpn0fEFasEGtLcksw/LM46IvXfFnuFeUTpVZd5?=
 =?us-ascii?Q?sdAUf5Rp21WyL3nUe5jsTp3PttEcWCPnjFGRp5thtCKIIMgiaMTJ5Yk6dSGd?=
 =?us-ascii?Q?5QBIgmga8FACIgVQRqSnF02EeirYx1/37rw51Dl9jz4CsTiGlfs0UcZqmlx1?=
 =?us-ascii?Q?+ZVwadh26C+fjEItkx+w9DKMWA5wEsE/hQ5vXhbY2JYdLMrLHJmuHS8YBAJb?=
 =?us-ascii?Q?Cj6RMxFveKTOjNYDp8u1U0UYR+r07d8wostBsk7Zyyr3r8WujxNPqoJ392V7?=
 =?us-ascii?Q?SB2EnolTve3K6QWnA62cVYiN/8goPTCxM+GH5VDj10KVRoJCZ7h1H/gKvvw7?=
 =?us-ascii?Q?88jB7bdweL/YY6necmIlSwaBsTiXtDw/hkOD6LZf4oQpfon5PDSJ7iEiHgCk?=
 =?us-ascii?Q?t3+Qae/VZJB1K4ruYuD/APO3UcY+fjYvTAv0bAQfFCs8QsB3yMvDgQUYc+FR?=
 =?us-ascii?Q?VxoDKm9MK09I3X50pQEN0SZC5NmCTnx2/W2qL+KcauEXnGN6Qy0YtuazHgRt?=
 =?us-ascii?Q?mxlVJqNh/62IvKn+ozfTJULCYd2M5zCHs7KTnowxacDRXLohdUDCavLQ4tEt?=
 =?us-ascii?Q?KMmw5ltnnCmFfufGqLlM+Kzllro2fvcfOV/M/mEPExzSGw8ZYeSGoQ6s1owZ?=
 =?us-ascii?Q?PGui31VsKCzxU9Vl41mPWRniFZcxXbHpdbHaF4+E68S8jIo0IEs+LWqFc8sq?=
 =?us-ascii?Q?/koghNj64TM7oCzvHzN5oNHTWrtok3KQMUltbQ4DvHjtvu54M1BNMvVTKjHX?=
 =?us-ascii?Q?9nUNifEumneO0PbFx8aFOZStiiNHgyITnUmt2Y+YRPM1QoxrX7GS5B6oGHS3?=
 =?us-ascii?Q?NkknUiawuLjg4U1IUHMkqWn9wrk4zG8QhRSw+k/fBbKGaONKUq7sKJ2trpsj?=
 =?us-ascii?Q?hH6XtGqVkLw62wzJHPS6uVEmbcOiW4Lopzn+QFY6nYfqxyTTuKhbeHNZfWKA?=
 =?us-ascii?Q?3zRetXOxZK3gLGBF/icFeNgyn8JoktnLgtP5Mige+7Ijgt9U0yPTf13SXAny?=
 =?us-ascii?Q?yUB2UWNvvtuSAidRjRIeiEFUYpg1asbURQX7jxQt/aXEHvFzUlVP3u0N6k1h?=
 =?us-ascii?Q?rfmOq8e6XwE1Kzw0TuxQzA5ffDyJD7MeVl2clP48UqGk1hRnlmyYAzuiZjU8?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fh3cWHASj/cwE2D8wpoQpvJwsFxyKk4uYM2BQ1VWPBJc6OLE90GAkUKvKnSwPHyiNhT1oYSfRxJI+5Jr9q5ZC+DU4ViRVV3OmOsm0geWWVPHVPfTlaDD810+Rfy/AIPsJ91DkiKlczUX25lTdH2iCNRyNHSc5xm9SHE7vvNBF2kHftNiZkoJsYcTY1TvweHOcwNdNKKxfEN03DlrfAPBnTVWwu/GybvRxISwpl8kadAtIEDAhJ6H2lLFCTvlWgnHkEZIZrXZle9K6Lvsp6D3HUMd6EMaZh2I3ADnbSAlU+v3vIdQYQquyvLUroHXlroqbdTY5wLmO4LgS4dCY6QL9l5CvyCSGUK9pufg7CkzL+xfPWPuvprt0AAgafzdNbnaokFSznvIwFYqcs0+HHtyHQjRntyqhbqFQCLEbE2B2tqN2tYd0gj/ArVqHqxtdx2dHMi5WqANWEszYzBUiGuv4XXAvHWGIj3TwSHYE4bAe+rRw7sFo4/YcLKsVS8QsYaJzc3QjwBW9iVx1/ks3FIKMOtHyGVNjDpalCYmkXs9N2IGxf11DAPdS4UIkr695G+Mcabnj4tkJuVGb0mRr9elgzyBOYHmBjLjQtO/32AhkB17c8f7pqGHzrhwsmL0Y5tilrnwxsQo++BWPVnVeFEIGBAovJMVxQMKPDiySq0cebYF2tiVrQG9P1OarXxL3JgZxG2zHHZp3uNEvMT5h6DYnNeZ8l2TYQdIRMaWN/qnjJUKfTncpGbwpbG/RfwMNncngZs8Zb3hRvdYLimoHDo1Tg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba58e54-23e6-4580-7e21-08db6bfba3a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:47:53.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3F6uTKqzjFXVjAj5AVmZ/9HswkAF0g90LfglCfshIGWn4uX42jXPCEHAE457wbN2NmU3UkObT5tFMnW2nNiYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130096
X-Proofpoint-GUID: 0UPZcrdhgUATjFXRnytOHgApF0pwHoVm
X-Proofpoint-ORIG-GUID: 0UPZcrdhgUATjFXRnytOHgApF0pwHoVm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function check_where_mounted() scans the system for other btrfs
devices, but in certain cases, we may need a way to instruct
btrfstune not to perform the system scan and instead only work on the
devices provided through the command line. And so, add an option
--noscan.

For example:

  $ mkfs.btrfs -fq -draid0 -mraid0 ./td1 ./td2

  $ btrfstune -m ./td1
	  warning, device 2 is missing
	  ERROR: could not setup extent tree
	  ERROR: open ctree failed

  $ losetup --find --show ./td2
	/dev/loop4
  $ btrfstune -m ./td1

	Or just
  $ btrfstune -m --device ./td1 ./td2

  The 'noscan' option is optional because there may be scenarios where we
  have a copy that we don't want to modify the fsid. In the following
  scenario, we keep 'td2' out of the metadata_uuid changes, even though
  its loop device is created.

  $ cp td2 td3
  $ btrsftune --noscan --device ./td3 -m ./td1

Thanks

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tune/main.c b/tune/main.c
index f595bfee0e6a..af0e58973355 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -150,6 +150,7 @@ static const char * const tune_usage[] = {
 	"General:",
 	OPTLINE("-f", "allow dangerous operations, make sure that you are aware of the dangers"),
 	OPTLINE("--device", "devices or regular-files of the filesystem to be scanned"),
+	OPTLINE("--noscan", "do not scan the devices from the system, use only the listed ones"),
 	OPTLINE("--help", "print this help"),
 #if EXPERIMENTAL
 	"",
@@ -176,6 +177,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	bool to_extent_tree = false;
 	bool to_bg_tree = false;
 	bool to_fst = false;
+	bool noscan = false;
 	int csum_type = -1;
 	int argc_devices = 0;
 	char **argv_devices = NULL;
@@ -191,7 +193,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		       GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE,
 		       GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE,
 		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE,
-		       GETOPT_VAL_DEVICE };
+		       GETOPT_VAL_DEVICE, GETOPT_VAL_NOSCAN };
 		static const struct option long_options[] = {
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ "convert-to-block-group-tree", no_argument, NULL,
@@ -204,6 +206,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			{ "csum", required_argument, NULL, GETOPT_VAL_CSUM },
 #endif
 			{ "device", required_argument, NULL, GETOPT_VAL_DEVICE },
+			{ "noscan", no_argument, NULL, GETOPT_VAL_NOSCAN },
 			{ NULL, 0, NULL, 0 }
 		};
 		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
@@ -273,6 +276,10 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			csum_type = parse_csum_type(optarg);
 			break;
 #endif
+		case GETOPT_VAL_NOSCAN:
+			ctree_flags |= OPEN_CTREE_NO_DEVICES;
+			noscan = true;
+			break;
 		case GETOPT_VAL_HELP:
 		default:
 			usage(&tune_cmd, c != GETOPT_VAL_HELP);
@@ -320,7 +327,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 
 	ret = check_mounted_where(fd, device, NULL, 0, NULL,
-				  SBREAD_IGNORE_FSID_MISMATCH, false);
+				  SBREAD_IGNORE_FSID_MISMATCH, noscan);
 	if (ret < 0) {
 		errno = -ret;
 		error("could not check mount status of %s: %m", device);
@@ -345,7 +352,6 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 
 	root = open_ctree_fd(fd, device, 0, ctree_flags);
-
 	if (!root) {
 		error("open ctree failed");
 		ret = 1;
-- 
2.38.1

