Return-Path: <linux-btrfs+bounces-3509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D840B886B28
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 12:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6128B1F23AA8
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409F33EA83;
	Fri, 22 Mar 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="anCp4Z3z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fybHh/Ti"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B043AC2B;
	Fri, 22 Mar 2024 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711106240; cv=fail; b=or/nQpF6TRxYStjpBs7rmfCUs8TWMGh8giRrIZMQ1FgfQT+gezdJvXh7LxxJgrZnMG/drmZ2mjre7fBGr1ymeJs7cZZZ1obhFhOUi/gttpOcl92Vp0R6T5S1CWERCQBt44u6vKlzQsn+GYtIs0Y53v8ciO0wcvaCjYaBBCnR6W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711106240; c=relaxed/simple;
	bh=1nwn0OPvnbb7lyNUo3lxHOO7HQyU7BUFJPsBtHuDcPs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qr/0tGMrorFdX5xvUWre/q6vcDDIs/6cb4906eAzSv/nsQMFqas9q+RcLPYJkmpHsVAF2Ll/PzAZFgXnmLPLGZIGtynz8P1js+jGK1CiTVQkKcKPbRAzijudQEqIkUoeB2ZMxP14t7gSLkhwm7HPxhSUmi94YqM7sbHAERFpx3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=anCp4Z3z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fybHh/Ti; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7Y7X5004067;
	Fri, 22 Mar 2024 11:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=httN33vCIy/FZxmlhcETHPj8eCyfClsoTuNfVhnq8cM=;
 b=anCp4Z3zdM9G7AN/LKxUsHbBzl+p5OtGejqaWXfBQIbPqhSwuPh59hkEYpvId+dUdJxG
 q2S1DBoiTghbPrtpAMGFpsv/irZ7TFq4UKZ7sCOYP4RkmgQOXG7QFt2RYDLAj4oBa1aw
 jOpwVbb2aYRZqxGS13azGtIoSmHd4iDGYsi0OaKifNP9SLGg8bFXqxTvW4N4FZoKTdRU
 YysFR4vpdv9DSCKziWHvG68CuqQ03AFnrIw0XU/Dh8Uk1K03svTgxbyaLsaZxBWo5fdx
 rQtbYEy5IPB8dOPLwi4aeoSI/ycn9zs1Q1GrmB/V+XKA0oc4KiqGE347LYHJs/mP0/O+ mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvk8vrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 11:17:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42MAHejp011141;
	Fri, 22 Mar 2024 11:17:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvf40pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 11:17:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS1w8qDBqkTnLPgLMjhyixNWJe15+3H9S0CmhOJ4pNHAd+Yj0NvWSnbJlD4Nq0B9kIfZfDPcUTZjFHPO7692QEPRZuIy8GSwigTPFNIoVLxITaYWmVNUuqQC2oPDNofUHv9OIjJqqoxoZMTyJP7xwiQ9fEDADFvRElqsUo7IQnE8m8wXJHsj0aSL/JCBCQR7LrzlsWvBOYgXhtk77pZOz8eCWBbPal5EOta3kfLfHb8jK4mRlwrL+QzjntDQmRG9OWmQzFKMtbGlzOKQxwbEcx7KDqr3YR8uy886rnZ5fh6AlReU4BMtdXFKTS6v4XYUfw/1sb7LAGuH7sgEVyz3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=httN33vCIy/FZxmlhcETHPj8eCyfClsoTuNfVhnq8cM=;
 b=ThZocfSWonaqBQPXAmv6KbnKHEIA2A5IJjFi1FmGU3Se5sRmAHLB2je3tCjDUWW5h/50l9dRUlSUn5EjG/MBjCbCO7y2hdKCkH/kkRn8NaPzY7QL3Ju7YmwkTfQ/vmuN56IIk4Cr8qsykHdu26PRDtlCvqjfGXI7B4OLR6xw0K7TkkCeSkzHEFBI/okv1kyldyvcRa6jGSk9tG9PHPptBIOSvFQfkkI3paQMytSuHbs/lQLkXmORr8ZG7dtc6+ry0cMpFn7Xuf12XLcFbXT3mWQ6xWx+UVdY6TRhYCb/dDG0VoEV+EG9arx5D3nv3J6rys7Mj1j+xuWcm7iqFM247g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=httN33vCIy/FZxmlhcETHPj8eCyfClsoTuNfVhnq8cM=;
 b=fybHh/TizC/GQ3NvcDVlUM+Kx+x7bSk6P5FOGxtZLBjrhwNXTCSPkS8tAwIW4Lu0TLG2kvwv9jWytFzJVROF9XCtzvHc89NKeH5zkc7jhxyVjoY+CtG/I/Vc+wcDIJQf2UCHJLZo7JelBfcDlKrIWlJioi1s4hRZwSWQFdlBFYw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6424.namprd10.prod.outlook.com (2603:10b6:a03:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Fri, 22 Mar
 2024 11:17:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 11:17:08 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v2 0/3] fix btrfs-corrupt-block options value and offset
Date: Fri, 22 Mar 2024 16:46:38 +0530
Message-ID: <cover.1711097698.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 06772620-0948-4f62-a429-08dc4a619ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QqEs3c6D6R4MHjmM31JWRWcLnHnF//OZBBLH/aEOsF2miNcsisna6F68DFiaNCTG7HGwLVvzHiflye5VOIiBYBVp4+FBSED/kMWQoMHLsvDg3jHkWtdhEZwyNdE5slJdeJHnbjHKQP95muQSBDpZnSe3xzk3BfZ4Q0l32QJIAXhAQJqoSvVqKpkIpADtnh00Ni2pV09LIWnvudQQumTlOywh0uJcIs5P5PQkV25FIeXOp9yEHMmFVubbPDFN8FLUejaKO3FCZKt4sOu6YXqR1qGXZwJAZdontaqGw533gQCllI66xLTQOKvL2oV8D2RHyJJtFSGKPJpNjnVdEwH3kUnviQAdy05m+OeBks+grcB1TI9cRfdRSYIwa9fRPcY2zerXx7L3dn7mX/wFatUCsoXgIhXQHmSt3/oI+ouWktEIMxMWFt+a5TyrQHgrxtivi9cfcbVtKHgfyA2v9Fws1xeazYTW2bbzTNraBf1rcD0xBKRarS+uLlqUt5zLpi0Y0mtohzWUMMB7C8rrCynTEqCRDjOSGiuXy2Zeo2K4Qh+XPEhBj2vvv/SBHStb+RgGuY1p5XB8WOH/15ruaImrw/78xgPelzXcAkwEVk1El38=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?T9ilTsLfQrAl64BcEldNUdbPtI2Iph+zBXc93XsSo0UT3O/wQCXNo+/3th2V?=
 =?us-ascii?Q?1D4wf+5ss4IalQ28hJKGgX5WcU/GwBTniVbzMnHeQGCy29UOtrTQu2rrlIKh?=
 =?us-ascii?Q?+/tH++QxKTJ7TbyV8vCudlsIFSvA7xvhsWtzfE7nUIsAy7fGKUxnZKwYWiVN?=
 =?us-ascii?Q?e4zSdewhaPK2gHBu9Rc3ny8iKnILtE5+MhxK6eN3qbQ0CK/1hd9UsWaFg+4z?=
 =?us-ascii?Q?eK1qWk3vlZAPWTXUd7zy1eNniJmkGaE8YVFCVel8goTuNoLwooIzAaR7XV3i?=
 =?us-ascii?Q?q8dX3dbOugVicmFiM+Spd1wTKiZYkklV7oLc6OYTci/OCrWJzVRfNK6Mmh89?=
 =?us-ascii?Q?0eIINl2XIQgXsKlZXZ4uMLtxC+72Bm4vA66YMNTwmjyi7EgGIPP+aIgXBbGK?=
 =?us-ascii?Q?c3Wy4PrhDoviGEhxbxrOUpoxNmdWMEqrtjuCnCltom7yKlty7+zH/Z9gRctH?=
 =?us-ascii?Q?oLj4koo3gw9Oi5QQ9eITJ3G5qsjZF9k6cxB/5Mwn4lgE51f9N5GzbU8uwO5e?=
 =?us-ascii?Q?y5JRJMwR4PhOXbQuaecvuO2pAwevb0My0N1nSP84rliKbSLxSTJohASAxbzh?=
 =?us-ascii?Q?hN7F94sG2kiwaaY+WP3DVkcJXHINfIIjmdzy4AJ42UBwoWkys9nekRHtwSnX?=
 =?us-ascii?Q?flYdAi3qVB3bYIF/CJAbTaLYJV+YmbMWbpXwP4SfXFysedLbJ1FEj/vJCaSl?=
 =?us-ascii?Q?ccLxH31zf00FrwP19Tuwb+/Tk4XzVxKhvBSSvR9ULjuCebH/X2KA9TJ1Kp33?=
 =?us-ascii?Q?UOyv4RUdwGXH1ieZnyN5D1YmJT8Tw1om9bPvh8QWIlLpu2XZui07uFCzB/TU?=
 =?us-ascii?Q?RsYdHk718f3Ol01m6jKVQk+kIKr4SjaPcx/OhrgDPx8oFwH01l2b//4M0IYf?=
 =?us-ascii?Q?6Wca5U9uWlhmwduH7viq3s4kYwxtO62+14dmEgzCyOymHtsIKkKL/tGelYNi?=
 =?us-ascii?Q?A7NX4khAIhp2/9VwHmsPuGR+kkA/txdqQZsDZRbg026NnvtBjUfUycCF7C6o?=
 =?us-ascii?Q?k7ct9pJcPps+vheSkGuAu3p1Y9izPAXhLuNV7Ysq02dy6btdATMf+Kjw6qTn?=
 =?us-ascii?Q?XFrH/d4aUoo4pgAJzOw+2mYz+B7UP4GA/D9bqvF2YU1F3ys4sulf1k4AyD2R?=
 =?us-ascii?Q?HS5F61GV6DUc/WVPM7MC6xoyblGGaW312X7B5QqeKi3nw/sz5hjpv+yPYdd1?=
 =?us-ascii?Q?vVIoMpuf6UfnOXD+feEEHVWsaEA9AgIQXGDlCUHU6Ny7Ud3gDERNKJPKOUyJ?=
 =?us-ascii?Q?vrgF6OyXUUvPYdDKuDvmI4BuWHaZuXlTZH3xkFTW7cYW8/nocbdQfxyqB4T7?=
 =?us-ascii?Q?md0bb8Sqk9x63OnkUteyJHBgtfEEywzhTtf2NmTt8TwChjbJwg8jbapSH7bN?=
 =?us-ascii?Q?B1SM2UH7Quae0j4xhLhL5gs3v0163ojO/jO91nvg8qb0kUG9g/bL6AHqK//K?=
 =?us-ascii?Q?p6OVItj8BPTx5L3CXlBzoQX7n0cgqA2iNcrXBCbIV7FgZyw002J+USxfHB6T?=
 =?us-ascii?Q?arKiD0jFl2JhgsNZanD6/LwFImZ8S8Ccdq5QqEChr7QxUYl1FK6kPBbibR4A?=
 =?us-ascii?Q?ZGsFtmjvdiDLNpFZzmwJJVqp2jRqQ/MhRCBn8rgHCfh2FdeJ16zxx5ta9W/c?=
 =?us-ascii?Q?4IxYmHrTf0lr8vf04+H43l3WC66FZsyt8NZ4SLsCTu/7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	j/RAamXthc0BI3Dds975ow4PDbGZs8wD9u4EDETX1N6+hjtOTtjGnQXbv9SW3rVqC+B7rD7Fv2Jdnafuh5lOm554DW7sq8HsjNt4XgPOjI9MQPcWl79jqAH30Le7+NkX63y4rwvN4Lm3jAYuIlkpGE1pipYJAiDYVpiGFqTrlM6R/tspxd4P5L+ntSFwxAJ9doYMZafYG1GVzOKh9/L0LoSrr/l6jtBfMUq/tlq5WAXEaKC73ElS6X8onYmw0BxP5pq2j58T13mDl/+DGRC3hyMc+oPgfIVhBy+vsS0md6dwuQgVh5XOa4G/JqCmwFsFfRrwjDw6P6Q8/x3KJmBkFtxbxdCsqfTNeptEN/2KlZ9znhQgljuOtWUkAJv0BLo4NHyBKhieMyAun4B2XPiL4O7dWqtUybt/FcYUnqbOdkb03Zr3Fh03gepm3t6WOzm4aFvFPFdRqPMAd7l/n+RKtwL8HZBiFSy5KGwEauPUr9NuwBEEL03uz7VNiS/XJzcDwR10eOUrRUunJHsFi0cBPTckVGgu0L3sn/kXjsTjC81hKrNmSMkLx+E87WpM5B4LosjqM1O3oJEJpbfgZ9s1t9yMYRgh9kKV7T7SZXp1FsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06772620-0948-4f62-a429-08dc4a619ccb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 11:17:08.3871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlmSSiI5tuhToEPNq8/WN4ZJwdpxoJoikbtsjlnZQjTurb8dphuVsGi2ImobVgbl/nD1SlSvt+Bj+IEM+b71wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220080
X-Proofpoint-GUID: 1gmxFeVHcPU6yBHvksN6p5PLj8xCR934
X-Proofpoint-ORIG-GUID: 1gmxFeVHcPU6yBHvksN6p5PLj8xCR934

The btrfs-corrupt-block options -v and -o have been replaced with
--value and --offset, so this patchset makes fixes accordingly.

v1:
  https://lore.kernel.org/all/eb2493499d2f30f43afa09e980589bb4f15e9789.1710984595.git.anand.jain@oracle.com/

Anand Jain (3):
  common/btrfs: refactor _require_btrfs_corrupt_block to check option
  btrfs/290: fix btrfs_corrupt_block options
  common/verity: fix btrfs-corrupt-block -v option

 common/btrfs    | 15 +++++++++++++++
 common/verity   |  5 +++--
 tests/btrfs/290 | 24 +++++++++++++++---------
 3 files changed, 33 insertions(+), 11 deletions(-)

-- 
2.39.3


