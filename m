Return-Path: <linux-btrfs+bounces-3400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3307E880005
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7611F21490
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729736166B;
	Tue, 19 Mar 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hc1iIpWQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fJrztIat"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFB864CF9
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860212; cv=fail; b=OKvvt11EGK87FGne+RRUpa6wPgw3D7AUdBVCSRK02xphh4LLxrMEDGoGvJ9xIyW1VFxEDJ3PGmsdvkyaZwR0i9ADxchTf9+Vn0TU8jRJepajgBetSfvH9PXzikqPUKGJ1icsEXzRrpgelkGDwuDqya8d6hh+Vn/h9MtmS2lYkw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860212; c=relaxed/simple;
	bh=EgMfFg/XCcUk/OncDVDdVjbUHu15K1iVzjjkzSfJELY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VZFEnRP3U1n2rn8LMMzRcWBGgTTY4RMn4Ja8xtiq3qN/fQjz2b5csvecWjNx36guXpmZX+e2yM6jvP5zcfgV3tWPvuSCb7stE7SbQvSE+N2+HQXErCqIzxRyojUFgdLb7lgaBmEyD5I2cw6mSdpMLNGSOaBm6AAyy7BgOin8brY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hc1iIpWQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fJrztIat; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHYFf010465
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=zC1lZdvdRBAWSFYqoLnXlLeo9XINI7btoG+7uECMiGU=;
 b=hc1iIpWQgIr+eLhpEM0aoRneKFDl1sRTD+KCfUemNC0vNhHbicI2SZvDlytE97T9OvdX
 mpjskL6diMlbIjouDrtpNR/U5qZz6nn/gngrBBC2molPVw+VCnNk6VRAc/ejgP30SdSY
 uENnY6ILUj8HnQPBE8YnoVsNbZBgdunN0/VZZE4wFRXrm+7h+NrEWjhVKUq6XUC9tTTL
 ANvrz1pcCcLiCkexIX7tRbwgo61A/LZI0RiyZ7MdKfnqBdgQIP4bvV9+bmh4xOkPKMK3
 lErTyXwg1pBokqfU5xOXYvXG8BPEJHoTzJWCe0/HycOCI5vr3G49PJof2QUwUQMQcx1d Gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2115rac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JDbQXs003718
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6c7cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:56:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5gAt1XRHhWMi0h+4HQa+l3O3VtAK3fG5L1qkkWbBc8KBLZOyYTDMNAivKpbNVyxKO8YE6y+3zgFxm8Jbca+euuf4ltY/nue7VDl/kQLXWqjoIxsXZD9u4yoOzBOUT+CtyozoIB4SZxTaYFP1327iyes8KIeS/zuRFxaS233eB4qD15gD1DGQCAmxLlMtPJ7Os1xXaPhLl7nZjquDXrHNXHlLQnwKDwvNcjrPzmL6oeapUAIqlkh56WSFxCmeJ1m54FRzRPXIuFiCknTmFDqlDH9y0Lk7xAiOLc8IxSjnCZbS6Xy+517CrV7lUyTFybrWEV09YCUAdijEH+SYM9U/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC1lZdvdRBAWSFYqoLnXlLeo9XINI7btoG+7uECMiGU=;
 b=JbNbPPvQJgF/PVrDqYpfqF6qvrDOG7Ha1AfdVnoaJE1HPjfWjjpZ/+H61Y3k2EugvdxDD71k+Jj3mxpFplS00MdHabJbuPywamoExj/zyIUdeD2/EaXErhFus6uBBzc7qG3qM2WIacUIZnXOVRJb4YbVCnfjdiVNZZBRh//JoplUvWGAvzoZued88+naVzj9iokQvQno4BMGrgYTtWMbGG4dLn2vOxU1NWIVBEFFa6a1m4VM4kf4agBRuHMrBTNc/9z6WpgmSjg7PZUXSy3IJmlk0trAiFnhYovfF/jG1J5ylxx9FPX08RgcNWsEUYuU+B4dsrVN1f3W+qE0ctqN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC1lZdvdRBAWSFYqoLnXlLeo9XINI7btoG+7uECMiGU=;
 b=fJrztIate7n7L8+wISTs9OuyRQLG2xayCMosNX0qz1ZtO1iPiNRJQVN5CwCT8JF0e7mVwM86BvSEjojsW+LlO4LvvHyumjAl7G0Q3XzhY93Pj62K/CzECZlJeDgQqMzYxVG8pnTQtFHkXShbtY4b97KoiTzTO8puZT+EskAaE4U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6120.namprd10.prod.outlook.com (2603:10b6:930:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 14:56:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:56:46 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 05/29] btrfs: btrfs_cont_expand rename err to ret
Date: Tue, 19 Mar 2024 20:25:13 +0530
Message-ID: <2d1abd207777598c5e681845dd234ba53190d157.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::15) To PH0PR10MB5706.namprd10.prod.outlook.com
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
	FQf7A/SyhQjgaA3fv++dBuFnuEME71aJnd9xztmP5RLYEosdQ04ld7KJshGyP+eylkI7TAqNzmEp3YmTHNEABiai18MkRGUx9c/WtUEpRRgozP6WiVW4QFaZe8i9uymkj+fwBVmEugSyqsXGvdnvhg4tuYRMvQeU2kFwSGPYPFNUcVSKcDNN192EhUn0ZZSRpczEAfCoFn8XAbxSY9Bx19PrWUSfjzpoGzIj8CjZt5rt84Ihd4VjEKFuxRryybuNaLb9agtOUuOpp36zMa7klRDZLSaU45p5b9Pf8PEompUm/aOlBiqglx1wbTAg/Ewqoy2d2qJQJsUQHQlK/5Pe2gx1N0BSQ5QT9IMtLCCx4YJ1gY3qCO9eOd3Qw0dk36EAsa12saTO48FW4wAZCP+5s6uoXuBXPb3enl9uKa2ivsp1RXmvLWte7EVNSsIo1nUFXblPksEuv7J4Ow0fUiQx0GjYfoOpw9G+AVHKsNISMbAKD2UWeVQ8Ug90ljNahYZcvqqg6Oii/Fty7kRhkaiteoIS1diBt0JvUbRmadSmOBc+Y1jLXQcLJMuGDeIyTFqI4jIOxtk9AJKgia2Io11K81xQmfY6yBxARAQnPUqJsMgJU1RkKX7y+bs5xAoaXzcWXjG5NY8E4TZT1C/RQp5BfxxOZdE3nUKARdUmO124TcY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pyWGwcoLjokdYJgf6JZx39CpFDvFt9iwh6A1yCcXT91QYUDaSWbYTJKBTVqH?=
 =?us-ascii?Q?8K+DHq/be1X++q7CYUTehJ4o1SEaKg/eSZTXG9QFNrVFUs0x0eMYMYKagUYA?=
 =?us-ascii?Q?5LxquRb/Zrga3LWidL0p+ki9oLEj5Xyks6njkeiyHOuj+rptXIGLSCXK6pQ7?=
 =?us-ascii?Q?f8qx4VJZ92qKApDXXCwbZsznd7g6y2UHq4tAYyGa9JctX6MXA9QSgfiG7zxv?=
 =?us-ascii?Q?3ntN/n/i5YouEeTeRJOSLZGrtKyBf6m8knnFBAWe1CoPYvESHnanCrxfRWXq?=
 =?us-ascii?Q?80zBa1wFyhqX+Q2oRTfLyVN3/c1PehvXel3jwPryROkQQmnEOhOnGN/hmfLz?=
 =?us-ascii?Q?ZeGzgteneLA7tOTI7FY9qWO2dffsrrmLRQ+k0wK2gJ3nKOFFe5GzwgFuejjr?=
 =?us-ascii?Q?ba1onUKo8xjhtifmiEkhwtsEoobPwmdf88pqvNvElGfLl2jeY1jDd90Lz8Ty?=
 =?us-ascii?Q?wrkXqJ5mQ4Y/nXDUgjzUBuMbIm+sRJZEX1NC6rlZlh3f/Fs9sJ5Z6HioFbD2?=
 =?us-ascii?Q?BmnriPe1D5jnwTlPpJEhLfptKPTaOsQbtc0JI/weHDP6qGNeBOj6kxWBrn8Z?=
 =?us-ascii?Q?3X53P87/irexEFwUhLV3EGtHUuFfOivhyrMthVhpBFQgOIujg2t0TV86mjDb?=
 =?us-ascii?Q?bXTfTr0o476ij2MH9pc/FW9K4lYHmAuaiqiiVq+aHF/mu7iqekUezTqLF3hu?=
 =?us-ascii?Q?imClHlK8UYHQZpLewgG8soF/rskbE74FWuf3DW9oxNnvtFagdB9Lj+A2JG8k?=
 =?us-ascii?Q?tcbkxpMR20Ro3lUAvvQnqwHF+x/kX0FihTw/ZhBOpIG1sQYxrbDKZelAUi01?=
 =?us-ascii?Q?YjxZPQNAc/XadhFR9CxLCos4yMF3s9W3rjeXFCOVG6kgfs2zqsI5UpAnoDAq?=
 =?us-ascii?Q?xL9b2hEvv/Ex/BT+TpXs6Zh1sdQmP/JUNIxAP/LdHoBJ0V7Nlv6rdVHxvC7h?=
 =?us-ascii?Q?8CpplDbcQ6je5tYBiHWWb6w+bOgN1Z9T4lOerxNdixilRYAyr750OWku4ZYI?=
 =?us-ascii?Q?+/1s5r6EhIVxOilEmvZBLHLBDbe8375HDgAGIjNbsfPbeWGfJ0kEqLx/yRY0?=
 =?us-ascii?Q?55cessHkpRTyk4gu8jWGj7V4UuZTfOr6jtJMsMJmAfOj9ExJAS5s3XxErngy?=
 =?us-ascii?Q?XIxkgncGVmWO50nRgPZuHnXgc6XIP68L+MspTIdSY5s/kXwi4OqLxsccWSaC?=
 =?us-ascii?Q?IuOWcSTI0q6vi5Ezmp7qGqeUmv7OZMOy6ZVDtF/08iTsuH7aX24EXIk1YpHT?=
 =?us-ascii?Q?lFRc1sUHJWwW+owiSdSb9215BuSmSjxBttj2So/VD5BOfgxW/trSD9rT7XUd?=
 =?us-ascii?Q?qpGpoqTtlCDg5Qe9Otc86VE12fXaGPYI9UBUuKKn17Rc5r2n5hi6JT7HmMOr?=
 =?us-ascii?Q?HKhSnlaPe7CZcXc87TMQdfvHmB0ZjT3E/qqY+oO20y7W31eH1LxLi+RuLsBv?=
 =?us-ascii?Q?iHSObKcDVG/2cSDMGO7phGGceuqsDizxLSUOflTFlKL+go87vjyHGzII4eiL?=
 =?us-ascii?Q?/Lv7IqMfDXr+PwvhFmoaEGav3tr29qj9j6kG83+K1yZHa0wznkc56Fl6QRBw?=
 =?us-ascii?Q?ahdhoxrHzVS1EMCZT8qB03PKAdeaXCu4/dExPbWa1T+Raxe+S2FrY0AKmuI0?=
 =?us-ascii?Q?7DEM6Wxcsco9C6vRLu6rk7HdrYp/gfgd0g9u4cegPA2D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xfjZupuP49XOpGnjPIYWMftDFxD7EYPpx+itOwbCqqEC12IbLzBymNkOjpk2vK5Nnt1KMmLT7+b3KXhIFIGIGnefoxkqVTz9veyiTTOGeARcdCqvtm/IdTwYtPRumTftL12qxx05KTGcffbtDwRWHYk+dX5G7MEK6mGh5k82ESQ7i3D8hvlhyuLg7rGy0PVWPkHpIie6ofhbcnkxQ3OIi9ibdTf9hdmtnVLCraE3dCwthkmj//PWtrUPNoCXlIsI4+bqjUHShOlYkG347aQxCHLFcko5SPRfwJ0V80xmEmJUKsI5f8mdshuz0zhbAsFu1Nnh5GtiJ5wIDU6WTX5nIxecj4oohVvdu3lIz9iglKSBRULiDWiRdwjRydZiJ9vQtaZekx4tpbVubsAANsyEiJ3OxEg8nsVcA4oNPAbbyE/p+acsqCJLE/i7InmiLTVwXccE03OawNK8P9voppYXEkqKVmy0/lzOGLxsjw/ZmVgfFnKpAjumCC/qtq2imYyf9f6RFJHi/VSK4j2h3PyiQXMGagZzyzWFoi4KG99zhzdxEDVtb77YIxWShwp4tIoxEoMH9AwaUAUE6UaR9TAlLM0D4csDT+EHsgKGcEbv+4Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f725e620-a9e2-43c3-9650-08dc4824cbf6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:56:46.1174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CeVKOD3w8ISqpcSY2bVsh1ZpXvemW/QhDee373kZlCk9BBFi11JM/Zbzu3BEylWkYzMRKG0X5lSJ2ZnuyaaEig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190113
X-Proofpoint-GUID: oXmGJ-i1jWhT8HrkEWJUVZQlK1G0GF0h
X-Proofpoint-ORIG-GUID: oXmGJ-i1jWhT8HrkEWJUVZQlK1G0GF0h

Simple renaming of the local variable err to ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/inode.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a2ad3bc8900b..27183225ac54 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4923,16 +4923,16 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 	u64 last_byte;
 	u64 cur_offset;
 	u64 hole_size;
-	int err = 0;
+	int ret = 0;
 
 	/*
 	 * If our size started in the middle of a block we need to zero out the
 	 * rest of the block before we expand the i_size, otherwise we could
 	 * expose stale data.
 	 */
-	err = btrfs_truncate_block(inode, oldsize, 0, 0);
-	if (err)
-		return err;
+	ret = btrfs_truncate_block(inode, oldsize, 0, 0);
+	if (ret)
+		return ret;
 
 	if (size <= hole_start)
 		return 0;
@@ -4943,7 +4943,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 	while (1) {
 		em = btrfs_get_extent(inode, NULL, cur_offset, block_end - cur_offset);
 		if (IS_ERR(em)) {
-			err = PTR_ERR(em);
+			ret = PTR_ERR(em);
 			em = NULL;
 			break;
 		}
@@ -4954,13 +4954,13 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 		if (!(em->flags & EXTENT_FLAG_PREALLOC)) {
 			struct extent_map *hole_em;
 
-			err = maybe_insert_hole(inode, cur_offset, hole_size);
-			if (err)
+			ret = maybe_insert_hole(inode, cur_offset, hole_size);
+			if (ret)
 				break;
 
-			err = btrfs_inode_set_file_extent_range(inode,
+			ret = btrfs_inode_set_file_extent_range(inode,
 							cur_offset, hole_size);
-			if (err)
+			if (ret)
 				break;
 
 			hole_em = alloc_extent_map();
@@ -4981,12 +4981,12 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			hole_em->ram_bytes = hole_size;
 			hole_em->generation = btrfs_get_fs_generation(fs_info);
 
-			err = btrfs_replace_extent_map_range(inode, hole_em, true);
+			ret = btrfs_replace_extent_map_range(inode, hole_em, true);
 			free_extent_map(hole_em);
 		} else {
-			err = btrfs_inode_set_file_extent_range(inode,
+			ret = btrfs_inode_set_file_extent_range(inode,
 							cur_offset, hole_size);
-			if (err)
+			if (ret)
 				break;
 		}
 next:
@@ -4998,7 +4998,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 	}
 	free_extent_map(em);
 	unlock_extent(io_tree, hole_start, block_end - 1, &cached_state);
-	return err;
+	return ret;
 }
 
 static int btrfs_setsize(struct inode *inode, struct iattr *attr)
-- 
2.38.1


