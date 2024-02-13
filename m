Return-Path: <linux-btrfs+bounces-2340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F888526E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 02:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF541C254F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 01:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AEB63A1;
	Tue, 13 Feb 2024 01:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gsW0bxIJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MeE4Gti3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3258233F2;
	Tue, 13 Feb 2024 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786893; cv=fail; b=LztlmtZ+HpnSR2uGWK2L3cgPqcLJ6gMea/NA67asGNyD5rT2oqbVuvNp2xxpPGnlPnPkAEZoLmgPImG/IRtWJDMr29w5tCbhwFAPUZat3KhfLQEGOnRGK/sIPo7mATqnKNIlKWqCLB41MQQzXq739Z/FwVJNg5TkB2fpz4ynTkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786893; c=relaxed/simple;
	bh=C/P4jQX4OclJH4Zv38u9LjTRDYhBS6FGn6aHpnX5gVI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EmIrLhCAvLTvRDnjjCE0bFj1wc6B1ay2CWhjQSOOnJJZwy/6VZzG+sLOM3ax4j9vza6dUlAUHFNCrNbjc8kn2E77wkdeGyhVaz+hXBdapybQNPj3EyulY1qxTRf8conCfPDkwzdh/JZs+fLMIKgEYcxEkEso+11LtOEMYYNlQU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gsW0bxIJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MeE4Gti3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D13SvO021798;
	Tue, 13 Feb 2024 01:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=xE8JIlA7gswMJg5I71fQNLpUm72rAIKSlzDq3FGNyCg=;
 b=gsW0bxIJhpGj6zVSgMexAm2Icw/5WjpgL1+G0FPIbcUX9RsOZx6Z63PuD6rlZCV7IRRz
 oAV4XJabVds4416vfIxZG70BmMaEIEn9y/1toBcB/u8CLcimoeizIcI/JvFudf9C3qdY
 2RFkhOXzch/gGK91O3Uazf/sKr7n9CyGxw/52rsxQpucPQxMQMO1FRTZCBYTr+setZqe
 a7hhq+Yp3KfjE6ZYPEQJgDsI/Ius7Zkiv9EeYQIpzue1LQ3sdegX1kt9DJS+v9Jql/7W
 jio9QyuSvpTlS90ca24EjTQshboNoH9lYK9KHrLMMkb4kj9YWpuzUKQu6wlBjmGLkhpd rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7w2303fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 01:14:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CN45Js024541;
	Tue, 13 Feb 2024 01:14:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykcuyjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 01:14:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HN1EqAlmhFOx1/jwO2uqNV9pDi+Ee1jFcQqpveAemjwbvGaEzarpI6BfI7h5dIpKqlifHuv+7j6jUGap7hl1Q8GOeYV92byfw5Ag+9npUVUOJ/dJtABagST4HyMjxPf5Pt+igDibYAY2caTyvOHNwmkp3daeAu90uBAN6zMHLHorIKgngFiTCjnqTLWE9W9FebW2ZDJiu/7KlmUjEgnuGVzD8/wbL7rMkFGrKTPtA9+YNseGOfWFHs3c2zd+/U/5tH+q3YkGYIxXrhuXxk5npv7crLPXdubYSsplD+jh4NnPOQ6dIQkxoNpTwVAIaT+pDlZ2mwFcKwIbFqanWuPPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE8JIlA7gswMJg5I71fQNLpUm72rAIKSlzDq3FGNyCg=;
 b=AWGD5JDup0OBfkhl5XgWXcaz/n9CIdnhl6/kaXX7ZX+va+MnTJ6lui/o/3qB3auEzXAYHKEh3ls+hb3P5K1krNhtY4aDkW9t5LFHesWECEBMdKSdEgnZf0FRYFnZB2UislbOfx4RnU5+4tc7xHpk+mcmLJJnMfWWE+vDMm1RGT2puI0G1V7Nc4raDRJudy7uuQZeAQsGYWTTdp7LrhfJ4wsMrmRChjn66L5eYOQS61zZtDASnXrkXZ+qWTBKsXjFHQBJpIG7nJiZaBl1Pnh+N7FCSnf8qhgpvlB2Q2rMc3sBTGuARPKmTtcbfk/WqLnJrDdlGnQXquJgYNs4cwLWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE8JIlA7gswMJg5I71fQNLpUm72rAIKSlzDq3FGNyCg=;
 b=MeE4Gti3UGPbFmlauyeeqdjH64X0d4TnXAsQ/NBHORWkc/W+ZyrDlEhJlqp4nvYqZecV3KyEwOGMtQlgH97OpgVH4Z46bGyE80Rpi+TpPNsCS+pbpMkoAXVUhoMlrRo8Hc1ma66sApUi1WJi/Y8VyQ7EAYnPTz/OKeaGIvF/vgk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW6PR10MB7616.namprd10.prod.outlook.com (2603:10b6:303:249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 01:14:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.035; Tue, 13 Feb 2024
 01:14:03 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, aromosan@gmail.com, bernd.feige@gmx.net,
        CHECK_1234543212345@protonmail.com, stable@vger.kernel.org
Subject: [PATCH v2] btrfs: do not skip re-registration for the mounted device
Date: Tue, 13 Feb 2024 09:13:56 +0800
Message-Id: <88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW6PR10MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f3f7ab-7fde-44f0-3d79-08dc2c3110d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	teGZ/G1VpD+RkzykGRmh3E0Vg+E4GZy3AZjoYyK+qOcw1qu40k6Yt5DMw/ffVy3j23LNeyWvVkolwrl3TH8Gcfpw3AMLRH88ZNd1vQrltYB1vIF2nox/SPk8FUlduVN9NbJxdGu5Lp125e6pmkiNy86wAaxC46ezyOaKDmiOopO7EexWSB+3I3+ISClg3qrB9P1wu7VOTCD53fLtA6KsLOo6VVGDVcaaRZorhxBLElzjOxC3Tnidgxy37FYl7SIi0S3v3CzQ8KkM70u8E3G4n6btLRvX4AU5gPbIC0DVNxupzA2oDUPWqsFD6N7GbdHZcTPKb3gAky3UScHcoUwTXQ1eeEGwxuY8DEAx+ABoFWrbpmr8yQYLJVKSPpT9SX1qO64EULJuwGml3uu8Bcu9vK9Jw+9RDr1HkkHxuRpdGmfbe0+yE12fbmjttFi/EPAxDR0H0BFOLdJFUcv0v5Klvs/9DvhLt0TGdRHMfr6hYbTjQuTnfT/3V1ZlYOa2UW2bbeZt4B4Rgd3GNQbl+dho66wLF2Wpp3nunIX9zyigC9w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(36756003)(26005)(2616005)(41300700001)(8936002)(4326008)(83380400001)(66946007)(6916009)(8676002)(6666004)(66476007)(478600001)(966005)(6506007)(66556008)(316002)(6486002)(86362001)(6512007)(38100700002)(44832011)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9BJtRgfgWLtE7ixdWiaUe+XNHvdlgRtC1uRRNCwGDcqGxbbxzOOBLd73lu5W?=
 =?us-ascii?Q?BNTtrQM/ZYY/hEBVF6xE6sA+U0XDkoiS+1JZzR3HVCjx/sckahoTbF5/FGd1?=
 =?us-ascii?Q?g/bO5Ju3bwth5YLbMjaM74N+oalQRylfckX5ZOtpIcwDjRdgXspcawu51Q3q?=
 =?us-ascii?Q?pqIOSbAQ0DMALZ63cnEGOEjjqqp+zbIOTfFQ9go5OOnEakYlm6G+9hjVP9TX?=
 =?us-ascii?Q?vS6HYeVC6JoUGZ8d/W+HQ5O9/qHndMu4mzlX93kWXoRj+92Ukz/t1Ykk5hWJ?=
 =?us-ascii?Q?vajh0OiZIS7JFAl783RlEbb3jYjR4Oj10Yy7/1D8gIk9rbd+GBX9S2DD0u6L?=
 =?us-ascii?Q?yk0RIhzMDX1fhlF9EAcJHOyoA8q176xKvqBAIDTrw8Ke8JxpQ3YNtVzNsB/P?=
 =?us-ascii?Q?XaNik5Tu8bkZdaOfUFWHcNh51HjD8g0hzFUMjWLprVeKLChPzyDHcCmnda7V?=
 =?us-ascii?Q?nbEF1xt2ggiw5RkadT0+CYoWSpqTdmt0mHVecMrfyb64Q7J+pHD7uxkPc+rw?=
 =?us-ascii?Q?7HRM1s7xNBzRuioB9OjMjAiUsccm1rC6kd7iUwfKYQsI65bpq/YFVLqBokSU?=
 =?us-ascii?Q?9LLF41ma7Pl57+9BjI00e7iHKjxiwDaKIGx8iN8g7bRH5XWc0OSOONv6Kc22?=
 =?us-ascii?Q?9owgUmyNWuLG1BwPYuGz/ATx4TLoHoRq9aUMxdnQX9N5dYa8XhxONb4dquwO?=
 =?us-ascii?Q?uEHjbQZjnI8h9B5SOXrHXCVix6fu+3bqcjmNG6eI5+5Q4zJMYaYr96QGduax?=
 =?us-ascii?Q?G6ZnB8H3uYjEYtYTJTZRPTMvO8cRJCyncO9/tusCRbj/yKmQdTkXaH1ff8dj?=
 =?us-ascii?Q?CBU5XQxgoG/2TnqEnJNuHB6wO3rZhJq7f+zj8A49V4Tc+vmjen7mUwvurHFf?=
 =?us-ascii?Q?QwBD8I6Q08IQRksRZqLUzbUOvf1DZeike078kWK27p+FbTnVzK1quB/cR0r9?=
 =?us-ascii?Q?MXZ6baqGo/eHZB1UugQPbtouynWqHX7FRECGWtcg+71hB6xXZbzX/BGiCxij?=
 =?us-ascii?Q?p1fqOzqa1taKtk7W/acmtjj1C/0i7zhXhf1JNcbzBtJkmp0+7pUijtVdmY/8?=
 =?us-ascii?Q?uP/bIhISEJCosc/ZX1T//D71PqMnWj2h9k3Hp5/KC20gE/4l9HiXYZipr0QU?=
 =?us-ascii?Q?OAO5qk+gNwSGfQFDwlPX0j2IJPoIxoL2SJEQmRMiUeAu9djuQv/WJCo8vdDQ?=
 =?us-ascii?Q?Zxl2uRV1HKaY0hQuhGnZpndOUZyi5IMJt72tCyIqkkYoDvQkuIuviAGfbNBr?=
 =?us-ascii?Q?2/NBgIOZkppsQP931Z/mQfXohSTSgsmwtrFFxaqXnvwZu++r4JR9Og4ZlCjJ?=
 =?us-ascii?Q?ryzV7AwN6yAXU5rUIpgW58ywPLgGPyteqG2AjGCtjqoD8gNGFzB4rWg2MAI6?=
 =?us-ascii?Q?jaTw6hwDwV3bRUuYgeKmqyP2frfbp6w2VK5S+BX3XIN2/CBXWeS6WBC8Wonj?=
 =?us-ascii?Q?/EScBZPNornZOt4JvCMUNzx+5ieuoqVVKy/N/oaQuND4yEi7yX4nC5ZV0UDc?=
 =?us-ascii?Q?RBfC7MTfLjiNC7+JKfw85iwXwv+LxjyFeC1BFYo+lJ5+4z3Yyg7Jfbs4xsdT?=
 =?us-ascii?Q?n1LVUwt6LMeCDJT0baNfEA8epKX4iT4GIOy0renH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ElFK+SZ9dQ1JofstprAN0ISAdrmVDj64XNVXUvsyY+cCRHfe6f0R++w709TmnV+twALTBloiHWTQsljcwgT75TX7F3qd3qEM/rvbZiK/DmoOwXubw4RrqhjDj18ZbMRoG9mTJsWZEiXDHEanPKyRhsaQxRq6swul6HCFo3aipGsxFYfdoOTXM+IYGmS6ruwrvlUyLVPahqIBbIAOJ9mmxa+4+z65VeGPOm7kF+FmqCUiiY7bPSAM+DLRgJ68AQorkWGASx2JZYLT0QpvCs4Em6fWnKUyCXTFjQRcKTQON7AnnLupsiEh2dj5vWSd4WJr30tCvEOYkd66r7/krOFRTXWtXyTS03hEQm05nMen8+RIDvXkGju67Be75tYQQLsOpJDfZ/8DRpkdweFYkCJPlM+4Nr2k/V+xISg/JAk6/ImxrU3R+D/Xlq4c+NTnslgyf5vl9UEMiMpIzehAzLURtuCbGekE8zW//G5N20vfYsFkHfhIA9GEheg+T3MUBx0IhF5WUfxZXCLl9IGl25ti+W65tDWX+Dpb3BphVjGaC/kRENt3IVS0kpcwcpdXAnkUJzJq2qL0X2Rzg21JTO3NBkba1QNmks/bS9M6k8zYzc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f3f7ab-7fde-44f0-3d79-08dc2c3110d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 01:14:02.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CkUzKdPC1PNLKxAuEIzJd04c3G4IHKlzbMzeJwNq9nJ078g7JIF6+FOO3BavSlTwrtt+OIbZcXigN6UmlfczA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130008
X-Proofpoint-GUID: wTNUZYkWAv1q1BSbW7UQFrHu9PlNE2vv
X-Proofpoint-ORIG-GUID: wTNUZYkWAv1q1BSbW7UQFrHu9PlNE2vv

There are reports that since version 6.7 update-grub fails to find the
device of the root on systems without initrd and on a single device.

This looks like the device name changed in the output of
/proc/self/mountinfo:

6.5-rc5 working

  18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...

6.7 not working:

  17 1 0:15 / / rw,noatime - btrfs /dev/root ...

and "update-grub" shows this error:

  /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)

This looks like it's related to the device name, but grub-probe
recognizes the "/dev/root" path and tries to find the underlying device.
However there's a special case for some filesystems, for btrfs in
particular.

The generic root device detection heuristic is not done and it all
relies on reading the device infos by a btrfs specific ioctl. This ioctl
returns the device name as it was saved at the time of device scan (in
this case it's /dev/root).

The change in 6.7 for temp_fsid to allow several single device
filesystem to exist with the same fsid (and transparently generate a new
UUID at mount time) was to skip caching/registering such devices.

This also skipped mounted device. One step of scanning is to check if
the device name hasn't changed, and if yes then update the cached value.

This broke the grub-probe as it always read the device /dev/root and
couldn't find it in the system. A temporary workaround is to create a
symlink but this does not survive reboot.

The right fix is to allow updating the device path of a mounted
filesystem even if this is a single device one.

In the fix, check if the device's major:minor number matches with the
cached device. If they do, then we can allow the scan to happen so that
device_list_add() can take care of updating the device path. The file
descriptor remains unchanged.

This does not affect the temp_fsid feature, the UUID of the mounted
filesystem remains the same and the matching is based on device major:minor
which is unique per mounted filesystem.

This covers the path when the device (that exists for all mounted
devices) name changes, updating /dev/root to /dev/sdx. Any other single
device with filesystem and is not mounted is still skipped.

Note that if a system is booted and initial mount is done on the
/dev/root device, this will be the cached name of the device. Only after
the command "btrfs device scan" it will change as it triggers the
rename.

The fix was verified by users whose systems were affected.

CC: stable@vger.kernel.org # 6.7+
Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Tested-by: Alex Romosan <aromosan@gmail.com>
Tested-by: CHECK_1234543212345@protonmail.com
---

v2:
 Updated git commit log from [PATCH] with permission. Thx.
     [PATCH] btrfs: always scan a single device when mounted
 Add Tested-by.
 
 fs/btrfs/volumes.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 474ab7ed65ea..192c540a650c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1299,6 +1299,31 @@ int btrfs_forget_devices(dev_t devt)
 	return ret;
 }
 
+static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
+				    dev_t devt, bool mount_arg_dev)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		struct btrfs_device *device;
+
+		mutex_lock(&fs_devices->device_list_mutex);
+		list_for_each_entry(device, &fs_devices->devices, dev_list) {
+			if (device->devt == devt) {
+				mutex_unlock(&fs_devices->device_list_mutex);
+				return false;
+			}
+		}
+		mutex_unlock(&fs_devices->device_list_mutex);
+	}
+
+	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
+	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
+		return true;
+
+	return false;
+}
+
 /*
  * Look for a btrfs signature on a device. This may be called out of the mount path
  * and we are not allowed to call set_blocksize during the scan. The superblock
@@ -1316,6 +1341,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	struct btrfs_device *device = NULL;
 	struct bdev_handle *bdev_handle;
 	u64 bytenr, bytenr_orig;
+	dev_t devt = 0;
 	int ret;
 
 	lockdep_assert_held(&uuid_mutex);
@@ -1355,18 +1381,16 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto error_bdev_put;
 	}
 
-	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
-	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
-		dev_t devt;
+	ret = lookup_bdev(path, &devt);
+	if (ret)
+		btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
+			   path, ret);
 
-		ret = lookup_bdev(path, &devt);
-		if (ret)
-			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
-				   path, ret);
-		else
+	if (btrfs_skip_registration(disk_super, devt, mount_arg_dev)) {
+		pr_debug("BTRFS: skip registering single non-seed device %s\n",
+			  path);
+		if (devt)
 			btrfs_free_stale_devices(devt, NULL);
-
-		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
 		device = NULL;
 		goto free_disk_super;
 	}
-- 
2.39.3


