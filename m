Return-Path: <linux-btrfs+bounces-3399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AA9880004
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B242820B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AA9657A8;
	Tue, 19 Mar 2024 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j7K5jLps";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PwDhULwc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD0B65198
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860205; cv=fail; b=UB1c/wh8WcPRVotKHQ/iZMoszTmGnmJ/LBf/N48rwjZa+FqiWxemjCisNxEE4iGgXgpqEqXBO0yu8+9H6IhzuD52vTQehjEBxIO0AG5GtmfltNI02liIvNF5UN5zDX5qAqdgSuVwikKbJMcboElk4Y2mGlVxpsu69FWpBJNXxmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860205; c=relaxed/simple;
	bh=02/cvQOxLIEbOzQAiSxxQ5bgWNAQotx0/X+TbvK6Yxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gm6T7ok/Vx0fB5FLJdxdvEXRVsOlkUF6keXttH35kbWKguL+cmNFv73VWTDb0sj8vXTdLDz2rrCx3CNo0xLRaNxpDONHrXhnob2U9Ac4+y0gHYUUbLwHoKBXfklJwVyaE5ArjdsCnEAE+6Ykm8fQueqB48coxoeVMQA4IoJoZZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j7K5jLps; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PwDhULwc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHtAn010428
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=waY6mW6CUoKjBqtTyftWKWSLGKrLXCjeXP+o4aGYQsc=;
 b=j7K5jLpsv3UUFRYAK1Pkgm2TYEDGbp0cuHOl/q/mHbpXrUfamyE7JwrsAQLYtAR8G3j7
 ODzX7rE+j4BULoPOnsL6Qxwy0WlDWXcNGLtIg3jL6Svl3YRhkklQ5Y+72ytCwpc2+oHY
 DPCp2Y74XYu9pO7muoNC0ywedhG7aOqrgVxWxI28AcM94Xcat6RH4OrJ0WxbSg2uaX6/
 MXFQVaQo17nQEpUC7/ZZCCG0Si1D4WDtqQUp1ANtDWL9NgkM8Ex8hg9rgqqTKc8dfiSZ
 63RFxQ++kCFWvYlT89wO6evsEoq3dNTy5QLql9ladpREf6s2R+TLDIHCmec+sek61ImL MA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3yu5ku9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JEqVjd015777
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6v5qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLJVb98rD0wCRfpMVkV+0wrUVrT953N2ZOETwjZiFy/kaTYbO58l7+HZ1SehKyyze+TfSWxzlD/nTuF4i38kCgCxdulqXG73twctAAZa5GyVv+DrUqrMiUPBNH7WrUngdL7w6q1fSLp3FeYef03WwwlIpJDOH4q4PEvHLgCL6A4D3Ox+x6smbMQA8bBoJ2bdLJWnGqLfn8BdY+yPrXx/PcHkB6CxQtGeK/rMlMw25ARER7fOMsi6L1BUrIDF0dSUZlhQsLV1nr3sRTXp1sfBlkSlhqAOHMc94h825scvNwpMmSxOqoxJuYhjHxUZrSRFWghIAxzQ9/nW0y0UIrbWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waY6mW6CUoKjBqtTyftWKWSLGKrLXCjeXP+o4aGYQsc=;
 b=KwiggiFWvPGDz7IkTUfRkv7IISR0spNLJq+vQ6qlXvBnuk25qs8kV9cVoHpMbRKJNF6U45G8Be2EhJ30Wtov0GsQ+1cHkL8sDKypTJecmrDLTrHeVPlQEgk5XDx/29ER1apCvUIJmyYa6GCBlxu27uFryJho+FiPO2emxX0SYa9d7ViC+IsC3U49qgZUDgEJnDh5+bp5w2I506FSwyUniOqURk7/w3IM4pnPesPJ0MfDURarW/OdvPR82vWC/tW+opviAmFfU9ZwPTDzFXkqDRoFVRle792IFCVJnZ5c80CfrGXFiv2I9sCvV2+XinNJP6o9hjKeS2vfxGeWSGC34Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waY6mW6CUoKjBqtTyftWKWSLGKrLXCjeXP+o4aGYQsc=;
 b=PwDhULwc73hZS9vXW9UlINZKwLvul894xVRdCfDJKw6AsXmcFzjx8wVmU7W5gnW6P4LtRtL/MKv75ZpvXRX9cynPhJwSIdCHTOjTFRsY18iR2HK34qY5tTFnyioJOYUkidKhTERkCzc7/Xp8ZaaK0Eom3M7hgZxMZuQdXXgYQYE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6120.namprd10.prod.outlook.com (2603:10b6:930:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 14:56:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:56:40 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 04/29] btrfs: btrfs_rmdir rename err to ret
Date: Tue, 19 Mar 2024 20:25:12 +0530
Message-ID: <2302e3c42bad9daf062ab26ba020a386b303900a.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6120:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CIFwQ3MEQwIbASNm+tW7hzQQ3vS07fcHSBAueWdFbqo+1CmWROXwgJMyWWSlw6NtEFsTxRLvuXwVh4rFSxKjhEgKqaW2MZVV4eLoEXincIbP18Ss3JaZrZA20T+iL7wEtQvZBsLE8XsW+VTVvnjfjrLoLsefLG41G5ulddomqRdPtc9T9v0nB6MsgaWFkNxy4ZDRd2lmEdqwXGhzVWJy+oVjkTr0LB5wDWCe/8upNVSA/Xdo0vzBHMqulF+PrI/Rt0ij4XHfS+uDq9mPOJXJLMmQGZjuFyyoJE567Xz/b7Qfd/WsDHnYqTY0slCPKY1GH9glbxEPciWltwLGaeNTYBkf/EcsFtE3cAcU1pMWQRCC7uo9zDcUR9rSkhLVkw9p8+lUZHiaPJcXc8KZThDLSr7v5LSgYqRAhMHK4ruaXyxVcXZG7jESozMYrQgbLvIg33Bj0z07RHzWNF5XR3ep6ID7KU9jrciW/NKqT7j4Ss0Gqn8zSl99iVsnWfBObJ7SKtuUkZuwN6z+YyqzqD6qPJ4WbSJFvQGJcS/eA8bjt1bRbUedB47DI4pW0ACY9COkoJM50NiSST3kjElYCvvAE30gWmSahNHcb4OOxeXLRA1qSfuypoJFKmxynyqjRODVceV7JkzmX0vKJVg5OrZ7G3dMc+9YZM5Wii0dGonpnmE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eUs+edtcYS65nTXTVSZ9OZt6VetwPqORsKp5latfXjvEdiZQhFKDbBBatU6s?=
 =?us-ascii?Q?qr+O0ezPfwSVvHbmHLH5trlNZdWYJvv5FuPORc9TiAXtiyf4yFU1vWOuWCii?=
 =?us-ascii?Q?vIqa83yLc8vCN1YbI7dLNgQTCyCEEQ6UId2+6P1UtClYXipd6GZDdKfVAn6o?=
 =?us-ascii?Q?2xr6AylMWlhI4EQAXTvha7XA3bMZLQea2edJnedchx/ydxkZBYTCzDMsuyIS?=
 =?us-ascii?Q?yDE2Hcul0YStyiEVB2E1DK88Z21HwfDJVESAJJdd8hjbvVIR7Ok84Mp1kOiT?=
 =?us-ascii?Q?FkDlu8Eg6G16siUw9G22E+wZ7Uu216svbJiwriAdD0iC/pBMUju/K81EkuAq?=
 =?us-ascii?Q?pqoDQGHqo+d4pDJAa84S1o+waYLt2QKiqM1otc5XnhKXRJ3qL7xPTITfnI7Y?=
 =?us-ascii?Q?iX6p/inzSgmZuVsXbl9KgLpL4QXRIP4jwEbHM19JL6MiaOcpWOkcs/TZ0CaH?=
 =?us-ascii?Q?GhHcso3lWXgCekzUrCmRnDFgJP/2IRM1etjj5SXeuufvOhAoIKRUSiGJQHPY?=
 =?us-ascii?Q?e6C9yT0pasCkgk4TzvXyVDEPFPi7jz6Y35GzxDSHvaa4zlAoqLmbqQ2vIn1R?=
 =?us-ascii?Q?g9Xk+ssloC1wvmvLrQAqHV2VTdwLjczF1UdJl7FCwNMx7G4wH54VzEdze+ZV?=
 =?us-ascii?Q?PrFj3OKa4Fxx9JzxMsq9NIXcmAKZvAtdGwLWJYC+cue6D42nm/WBhp/ttPc0?=
 =?us-ascii?Q?1O1Giq/KM/tEpjL+P7WTrUFcL+1DBd+lswWYQWj50c9noGPE9mmR/FoEq8Ta?=
 =?us-ascii?Q?da4NsKJnF6JdDvAHR7Y9qlHhx33+leh59x0jvCca5fmTz/HRRV7zriEereRZ?=
 =?us-ascii?Q?gJs57Uh0tQ6ycww2nQrd9lJDgFVy6GNtuzXCHAt8DX9r0KCQGef1zVow3RQm?=
 =?us-ascii?Q?u9sf2AIjorLZvyGKMor5EDoxTJoHq+fCnn7Ja/gSJPH4A2yZH1dk8nRVB1ot?=
 =?us-ascii?Q?KkihCb5o41Ekza4Lo5FsAdBd/zq7iqvjHXqP7rnn/+rXSHRtuGxC+BywJlv7?=
 =?us-ascii?Q?gmfQBV+8HLVouhEDLC8G92+mvRkGoLaZdagrtsp3Xb44kDS0GEr2Z4I4raqS?=
 =?us-ascii?Q?2KJlq0s2Sw46LBKA+sKLks4sDdb8Oe8LF22W5RjrAW1cO4qsz64bxJBmmUVt?=
 =?us-ascii?Q?de5vy19lk26XRBEon+nPmYh8l+oeorWwD0ef1ms+R/G16paiAwCM4XirFHRd?=
 =?us-ascii?Q?UFwrhub4Mpe7NYfjvJedTR/qzeUPTtWLPyskVO1XHi7q1zYKQ3yTN2FZc4Gz?=
 =?us-ascii?Q?Uox4bhLBRT+dhgto7jOuj1KNk0lJVE1GmONCFZUs+umZ1xztOJY72jxyJB2/?=
 =?us-ascii?Q?WShbKJoyNy7yp8NDFkEu2l4nKAEjQeHy7b/X46plRqklrAO2jORJ1RLyxPdK?=
 =?us-ascii?Q?sqLBkS4rJAf2JeVszz2fsDQoR+U6XBaSweYOfWE35zJRqURItDFzsli6Fohe?=
 =?us-ascii?Q?vRzwAW/INC/M5B6+bJALk+1ANMT0MMKUm+jZEkyTzc3eiYP6Yg23goc4oeff?=
 =?us-ascii?Q?7VwvVVw5scjstNrhyIBRrQAY2e2WOIO/HXZqFjwul6T0lNLCpgVlM5RhEu/G?=
 =?us-ascii?Q?5buguZHmkSqjmllxxpenCAGKbG18z5yD7l0maSnp62SDLolO2iM5NKgOcBlQ?=
 =?us-ascii?Q?rZ842woX9G7usRXBRH/ZUGQ9SwGq5po+XMoLmey/UXOS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UDCbuW6WyzVjERdOVVUTf5hFMWeMviy3KU2CtVIsWHdDDU8I1+77FiIhq+DgDM+4zkwDmrQyKaCLwTjYJOjSGCm6GT1kUVDMBayjiizDdYgdc72akZRC7bWToHvJ57fefH3ydCSvfjTHG8rYeD5a9xvn56e+raXuUTwRtpEjcmMAmxjx9Gk+sHBE0C7XhKA7xWMhDya6m3Nbi4IzsbAvISnpKFktxJJvftm1ktJeZ3wVBedqqjEYaHH6WM+mC1TuuoGmMjkvyL7rmelwm/z3130isu+ghX5tnnAXJzsCj3914/rar54WsDtXYp02slqSeIO97744O91gx53bHtBZ8PD+l1GXe5lp7DcIpAkna5z/3WRqg9IcANItg2R8F9ZCWlsB1/eQ6BtI5cVKrYLSeu/bHj4YQhlgE++XJ/0zVyn6HV7TH/RNn+XIkbpqi+SfE6hjTw+/64mWTaLAU9x35cjlnMZCyILprgEKY+1EI4JtMMCeNwYbQEuxKjvyMXyMqEWHDdDYucNxKuRJrxdgQT409+6nmiSaYvJv3Tkb5OraLafqoK9/3XL86XkzwPdN0NBs/5ca+vOqdA8204YDyNxtZDokwd6YohbNItlsI8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e579580-62a6-42c9-c295-08dc4824c849
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:56:39.9424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbWVriYpev9h9ztstGBX0eEFK4dW0lAatxfvS0vVDXqeWME5KVp0Io3PYwC+ePukDUdKBnA3NQdXy8+OjJD0uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190113
X-Proofpoint-GUID: L9AD8HfX7Gyt2d_Na7j267WheaUgj-p1
X-Proofpoint-ORIG-GUID: L9AD8HfX7Gyt2d_Na7j267WheaUgj-p1

Simple renaming of the local variable err to ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/inode.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 37701531eeb1..a2ad3bc8900b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4635,7 +4635,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	int err = 0;
+	int ret = 0;
 	struct btrfs_trans_handle *trans;
 	u64 last_unlink_trans;
 	struct fscrypt_name fname;
@@ -4651,33 +4651,33 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 		return btrfs_delete_subvolume(BTRFS_I(dir), dentry);
 	}
 
-	err = fscrypt_setup_filename(dir, &dentry->d_name, 1, &fname);
-	if (err)
-		return err;
+	ret = fscrypt_setup_filename(dir, &dentry->d_name, 1, &fname);
+	if (ret)
+		return ret;
 
 	/* This needs to handle no-key deletions later on */
 
 	trans = __unlink_start_trans(BTRFS_I(dir));
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_notrans;
 	}
 
 	if (unlikely(btrfs_ino(BTRFS_I(inode)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
-		err = btrfs_unlink_subvol(trans, BTRFS_I(dir), dentry);
+		ret = btrfs_unlink_subvol(trans, BTRFS_I(dir), dentry);
 		goto out;
 	}
 
-	err = btrfs_orphan_add(trans, BTRFS_I(inode));
-	if (err)
+	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
+	if (ret)
 		goto out;
 
 	last_unlink_trans = BTRFS_I(inode)->last_unlink_trans;
 
 	/* now the directory is empty */
-	err = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
+	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
 				 &fname.disk_name);
-	if (!err) {
+	if (!ret) {
 		btrfs_i_size_write(BTRFS_I(inode), 0);
 		/*
 		 * Propagate the last_unlink_trans value of the deleted dir to
@@ -4699,7 +4699,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	btrfs_btree_balance_dirty(fs_info);
 	fscrypt_free_filename(&fname);
 
-	return err;
+	return ret;
 }
 
 /*
-- 
2.38.1


