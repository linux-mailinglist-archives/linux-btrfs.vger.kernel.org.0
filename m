Return-Path: <linux-btrfs+bounces-1821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1C83DA28
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 13:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5761F26B38
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7326918EB2;
	Fri, 26 Jan 2024 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nTil+tUR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ms0bVeqB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D7D1803E
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272111; cv=fail; b=Ig4tTa2hso2yrzgPDrYWrfhliSfGoW13VKNU7trKF2oStBpIRE6csOPTkbE9tXzDTKOR7vAOAkW28g54JTWpyP/A4lwC/bfjjua654aWL+HlbLpMvpa6WXyUsZIAJSxNMfFkNMUIaua3ugGPtHaP4jPJIWOQsOxUxUhwn7rHzRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272111; c=relaxed/simple;
	bh=rqM20iHUWXfUJC3wQATZEZIUR70wB4uSLORNMjAIf6Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X+yrjOirNs7r93/oV4ljUo1cWkYOZ2/rYowysCEUnc8fgUxR8slNlMybAa/0A0992MYPndjOXET5EN8ls6ssSgBkNqlvKcvjVk5uou71n8gV5IOXNmkSeuAPNY92sACjp+Xilw1QdtQYLQJLr+4nzZEtiuZroXJ8cX6CyinEHx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nTil+tUR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ms0bVeqB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QBUtWo012809;
	Fri, 26 Jan 2024 12:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tA9L2yjXwK/3Wz4sqmrc4oMPdgdgbvJTQzqzuvIPl94=;
 b=nTil+tURErB7TWVxykXbzfSrxNR8scq0mEs1TLlF26CKO0O4qej1Atc80gS1EOw/66S+
 7tYGrR6giM2tA9+USWPR6KbpQoMvHcVw6djr5Ymd9+zzFRlyUkbgmb+51iNJXvCx8+Wt
 8d5hQY0Bzw6GfvFBfd7+Nxq7aszf15IerWVvAYBIasV7cdz2cLLhZCnvp9ytzFa0IBYQ
 AmtY8k+RAD7+1PwL7AOiln7jfwGBEHEYIGiaIyrskmwgtXAFs04shze7pieK+MKMLZkc
 ZNT9RsaN1jIXN0sMQ9ga5bWSQMWAEEJnoL9EPgdCjIvgLRzE8Nl4gyDydQDo0nEhkoJ/ 0w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cv2330-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 12:28:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40Q9u8li011914;
	Fri, 26 Jan 2024 12:28:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs327bgk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 12:28:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4N2FLSnSDgQtQ+FjEGG7TO2Zd6UFb6ufULE4Rriq2NHklxe/P9REeUIE5BKUWqore5YinzBHqQEu6Fd1/aUmXvHtU7ILNEFAzL5kFKcELXteIkkrbSNbxe0v44/bdftR9aMxeuJXPf5B+lCHJqJ2/IcY5E5+tuKQRlikloMkpDARjqLE/yTWmirFBDxrUQTa7Ayu1eqCq3QMMCozPrCmqIuh9Soj+wifBhspf8bMSQ/M9NlSti0mB420SPvAAYy9rkGRXDSQ20WoA70U2vnFFY8j4cXt/ZdqslJ8QWsTQjDBCinWUcf6scKHtVVhljVl1APwszAi7q4oW3wxqJfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA9L2yjXwK/3Wz4sqmrc4oMPdgdgbvJTQzqzuvIPl94=;
 b=DsvRV+f/yyfMoP0DF7J72+JvRA6RLnrdf7QAOLkhvCVihTm8BNW897ec8XowRkPBgJbzldybelbUiIm7k7VEw/FT4xdmOAk7F62rJBH7koBtsVvUI7KMPGXGGmj720RC9Xv1CH4j66kwYpkOMKUPf02ck8tiiAPX7TbCEZyrOrspt8NNV7szeiaBf6ogKB0evjQU6g7Hpe1gqr45+D6EmfEbcVv31OnuIr5ArYk+IC4+NjQaUFtBiGyiwh9+kxmY8LFxEgJIcZHPSeHzJM/okMraHADdPXRKr2Wrseps6gIh9T+jCDRJR2CdqfEk42LjHCQiS9pv3YHW66npQ+aV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA9L2yjXwK/3Wz4sqmrc4oMPdgdgbvJTQzqzuvIPl94=;
 b=Ms0bVeqB0d48tc+Vhbx2OGiWeo3zGVB05p+vcAnd3JpLhBPbzrAZhyEe/1S6GUu1M+HBuBqMcRrOkyuc1HJ2QnFg9cdfsVL+v+YAraURYLT/ZYWE7S6eaeXGBPSJdY1M/LWE4HHDjEZwjYm88E2XLNbWoZ7YV95U+jeLDxC367s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4142.namprd10.prod.outlook.com (2603:10b6:208:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 12:28:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 12:28:18 +0000
Message-ID: <76160d68-d3bd-409f-88d9-7723a1e4e9d8@oracle.com>
Date: Fri, 26 Jan 2024 20:28:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] Error handling fixes
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706130791.git.dsterba@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1706130791.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: d6efe9c7-8ffd-4ed9-56b9-08dc1e6a469f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KQpVTdVDmt/E5VNB3F5Lek+3/KxUC8MiWagIuomyg7BjCI4JJM1a3D/kqwPGYH8ozr0Xrrd1vVqmqKOEOQIbnv4LnGxpKt3uGDGTFFAo3tG0tM5B0ueEAMfazl7FjUXNqS6SmA7HwFkyPBrkACDPiB+1vzNhyxVaPIsSW7SizDH1oN5JYotn1ikXV7Z+AZXc2oTz1h0ofWRlIQ+O/bJrkzheEvzdOVSo7ir7drFrJX60oupmgSbwiLpH8aOWOrgpefqWHzUPKjkkXTaxKAPAS1D+glBnWcOxXn6Bsmg4LW94jTcTIBzMWZ8b8qEcZC3Y4vc1GqSdUyQZNaKDU7rZJ1GIsEUYLu7ZHd17LWzl+vVuTOjL2yUOx59SHkdNeyE7iHvTjVWBo0JfhFXZ3TRQ6/8gIxdKqWs9aAcKCBF+C7gRVuzZQUIZDGOrm9I6QvrNBZlsLrLIkSmwSfNt20WzCpmyq59vjejGzqafxKP9AoXQ80WdgjdaJNXrL3KKH/KYPoez1w2YtVadZBab7N/kYaRDgLw3sVfrGvpysDjrQAtW//E0Nbz8oUV0y8QQvPgK6jjQyLkt2PuwvSYgGXp/9c7Vkc3ub99YICYsiKdBKjIeT+1MStDNEA5G82wr1Uwp5emwY1YKBN3JZp2PSxp4kg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(26005)(2616005)(6506007)(6666004)(6512007)(53546011)(83380400001)(8936002)(8676002)(5660300002)(44832011)(6486002)(478600001)(66476007)(316002)(66556008)(31696002)(86362001)(66946007)(38100700002)(31686004)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QzVLb0lZVHhiRUlQQVJpMW8raEZxcGVEd2xYYlNsZ3JQcmhMWG9zazdlU3ZI?=
 =?utf-8?B?K0g0MC9tVXBreVhtYnpSQzhLL3M0eFFKMVkrNTB1anNLYyt3QWxGM2RWSFpC?=
 =?utf-8?B?YVhzZDVaNnhPQzJ0M2o2TnJiZDdhT3NQK21GaGpVTU91VE8vdVNwWFJESUpO?=
 =?utf-8?B?K1V3aURBeTNWNEFQaXUvSVREUER2ajhyWFQ3SUFOL1M0TDh2TGF1L3paSFkz?=
 =?utf-8?B?aExHTzNQc29nZVRwYnFYSlVMeVJwZVRaUzlhQlA4L1NjM3AwdTlremEvaFIv?=
 =?utf-8?B?TUpnNDhBRDhHaDdzWDN1K0VuemlnbWttTmFlQjVxYTNEK0oyQ0NDODBFSEJK?=
 =?utf-8?B?Vk54YVdDM3E1MWhqcksxZVB6M0RMZ0tpYmZ4SnpuK0tsZUNXRDNseG1KNllj?=
 =?utf-8?B?aVF2NWdsTzgyV1dmZVRoUjdRMzFRT1YzOUhuZGltc1VmMW1IeGV5SGJ0U09J?=
 =?utf-8?B?NStxYXorSS8yUXpmNWsvZUpKMDJjcmV1dnZqeG1ocS9OZVNMUGR1NHdrQXk2?=
 =?utf-8?B?RGVkdWVEQ0J5VnQvUE16R3RHL1lsU0REdUltWlZrNjR5TnZVOFh6SFlSQnov?=
 =?utf-8?B?Yjg2YnpqdU9Jc3VQNEswZWJSOGxKcEdCQXNvdytTcUxtTmQwL3VCOGtJSUph?=
 =?utf-8?B?Vm5tcHE4ck9MaWRBU0hJeFZWaGF2bGkyZkxHYUZKcnNyZHhLSnRXaDVTdHJp?=
 =?utf-8?B?UEk5Umo2ZU1URnhlWllGbVVQZGNCKzBEODRzTXhVYWt4M2RMSStSZHVTRXZz?=
 =?utf-8?B?UmFUM0pVVGZTU2Z4cVBsQ1Z2Vjl2RGpLREVwSzY4TURIeUdHRnRQaUg4UndE?=
 =?utf-8?B?NmovT0c0cnZ6cUxiZDRjNUxJeXNMdXVwTmcweWoxT082R0Nidkh2QlNZa3Bk?=
 =?utf-8?B?Y3ErNXlOcEkwYUlsL3lVUXpPYWc0YTEvNEE0K3lRcDYrUDZvaS9md0NkTFZE?=
 =?utf-8?B?UzQwYisyMXZLV21iazYwOXByUFFqcHkzNzF5VlJLbGpkc204ZnBSME4xU3NB?=
 =?utf-8?B?V0xyNDZiTkR5Nm5NeEJvNW84akNna1k1cG1kNndKS3B5enlFVHhrbnpQdHhi?=
 =?utf-8?B?M01kWUs5SnJuSWRoZXVVdTRya1JNbmZDQi9CZ25ud0RLY1RJKzl5andrYW84?=
 =?utf-8?B?SWlhQTczenpVNFNhOGpHd092NWw0Zm83NjlLTVVjVkVpY1pLKzJaYm1sOE9C?=
 =?utf-8?B?TERGdVpUcllqV25HdENrWjVsckxuekIrems5WlV5SkpFbWtkQjV1R2d0NlU5?=
 =?utf-8?B?US9NYWtjWjV0RjJFMDAvRENidFpXMzJBMWlDZnlhTVA0Y3NoODQ3cmFIZ0hk?=
 =?utf-8?B?bW9SQlBEZDNCbFZ3TXJpZllQMld5MHV5N0pmL2NBbmtlQllxejE4TjJaZ1J6?=
 =?utf-8?B?eUp1NzZxUEhrREJqdy9TY0VEeE1qN1diOGpaN1ZqSGdNYUovV25QdUp4UlRH?=
 =?utf-8?B?Z2xWMW9Jb0dBQzhyS2kxUjBXZnVJVVhhMXE0eVNGM1QzOHl0M0d1ZUkxVUgw?=
 =?utf-8?B?MjU0MkNyTjYvWmJWZHd4YWZhS1l4ZlJseDNqSUxGcStUMTkxN0hkeHpTbzFv?=
 =?utf-8?B?OHpVVFc1SnJGdC8raVFZak9VcVJ1UlovWlVRbFV2RlNscWdLS2IyZkQ3OHJX?=
 =?utf-8?B?dm5CUXYvbE45cGdZNkc2eDZUOGpEQTZhbnFuNUZ4RStQMlIrTGFXQ0Evd1du?=
 =?utf-8?B?UVlBemtWNnhGVWNzajVmZ0w5U01MZDU1TW83UzBNOERKMi9TMnBHcWtDNWpa?=
 =?utf-8?B?OU9JNFhUcll5VDBnaU9VeVNUcGtsamc4cTExNFhWOXZDN3F3NjBYTXUwVEZN?=
 =?utf-8?B?OW5zRXJ6ampGajBqRTM3TFRrOC9kcFBCYXhrU1BoOG16NHF5Sk5jakltb2lZ?=
 =?utf-8?B?T21xT00rSDZpUFBLQXNyVzFob1dpWWZXeTJUM2RDWXNmeTY0cWt5UUJUelRi?=
 =?utf-8?B?WHU3NUhJNmVITjJ1cXJWT3M1MzduYlgvdGlLYWtzSVpvTVZ0NFNQNUVqdCtI?=
 =?utf-8?B?RG8rcVp1MzNIbUpyN0pUUEpuOGUycE1ZNjRFV3NPMGNWUXA1SDcxRWkrazln?=
 =?utf-8?B?UjNoU21uelowUm94ekUvaUxhOUQ2VWkvYXU2MXBvVmVRVE5XUWNZU3p5NWRJ?=
 =?utf-8?Q?uZWlNw72Op8SVuIo6g2FVNb2X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XkrD87xeCvzthJvG796KACSIuF9BxWa5c6zBgdMLqbq/uI1dicxKPnWorlM4unp1sbehi5WaJCt6D5vE8kRngETaj76a/usRwTxfsJQV8v5jDYfXgVUT9hx6vV0DTqQsI4+iI9lz9mmsf1G/H2N8dFJj9J9lvmH56ZyZy2nhpA4kRBbQPjC55X1EdbH4ogMDpt8CagLo2BkQRRAmcOGl+ZU5+YWTj6iEx7S6asRP1HfEwPAFgGz5RxLOb+4/qC2C50LvyCrcQvZOWkRgER/W+CM9EXVvTQXdNh3NSG+2RDmYz3MpZhcIN1AneFUba+09zrTLYle7a5OCqVtFqlnzSe5Bz4pgCJ+LMAm4mdV4Y878uEOMAyHUDlnGFl/44XbpxW+kjVo3QGnvqnJmJRzkdO53knudYFjI+YFk6VC3qTkiqdohE76qqIvRM1JNvbMozh18psBrrLPGdovAdP7OmIqN095Oa3ETKPdEj6brWkny0rahBj74WiuwOiWAQhvwKS/USbG3cL+9dR4Q/OPuxHnLRyLYBsxF7xKpmjJEL0gwoH64C7E4jLSjWZapPNoFfMX1JOdnI+W5h9IbqgsCgT+DAVV8aqP2mxQWF1OH/sc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6efe9c7-8ffd-4ed9-56b9-08dc1e6a469f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 12:28:18.2601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9czxuk00ZOX8ZZT8E5s49gQSeEC0Pv1G0QEE4whlK5DtAhKetBxAXwEXAZiq6LNMotnExr9s4j7ogmrccw2LDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260091
X-Proofpoint-ORIG-GUID: kGTeQF-jR5CW5vsNQvHC_urYEjfM2Y_A
X-Proofpoint-GUID: kGTeQF-jR5CW5vsNQvHC_urYEjfM2Y_A

On 1/25/24 05:17, David Sterba wrote:
> Get rid of some easy BUG_ONs, there are a few groups fixing the same
> pattern. At the end there are three patches that move transaction abort
> to the right place. I have tested it on my setups only, not the CI, but
> given the type of fix we'd never hit any of them without special
> instrumentation.
> 

What is our guideline for the error message location in the function
stack, leaf function or at the root function? IMO, it should be
in the leaf functions(), so that in the event of a serious error,
we have substantial logs to pinpoint the issue. Here, despite -EUCLEAN
we have no errors logged, in some of the patches. Why not also add
error message where it wont' endup with abort(). Otherwise, debugging
becomes too difficult when looking at the errors due to corruption.

Thanks, Anand


> David Sterba (20):
>    btrfs: handle directory and dentry mismatch in btrfs_may_delete()
>    btrfs: handle invalid range and start in merge_extent_mapping()
>    btrfs: handle block group lookup error when it's being removed
>    btrfs: handle root deletion lookup error in btrfs_del_root()
>    btrfs: handle invalid root reference found in btrfs_find_root()
>    btrfs: handle invalid root reference found in btrfs_init_root_free_objectid()
>    btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
>    btrfs: handle invalid extent item reference found in check_committed_ref()
>    btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
>    btrfs: delayed-inode: drop pointless BUG_ON in __btrfs_remove_delayed_item()
>    btrfs: change BUG_ON to assertion when checking for delayed_node root
>    btrfs: defrag: change BUG_ON to assertion in btrfs_defrag_leaves()
>    btrfs: change BUG_ON to assertion in btrfs_read_roots()
>    btrfs: change BUG_ON to assertion when verifying lockdep class setup
>    btrfs: change BUG_ON to assertion when verifying root in btrfs_alloc_reserved_file_extent()
>    btrfs: change BUG_ON to assertion in reset_balance_state()
>    btrfs: unify handling of return values of btrfs_insert_empty_items()
>    btrfs: move transaction abort to the error site in btrfs_delete_free_space_tree()
>    btrfs: move transaction abort to the error site in btrfs_create_free_space_tree()
>    btrfs: move transaction abort to the error site btrfs_rebuild_free_space_tree()
> 
>   fs/btrfs/block-group.c     |  4 ++-
>   fs/btrfs/ctree.c           |  4 +++
>   fs/btrfs/defrag.c          |  2 +-
>   fs/btrfs/delayed-inode.c   |  4 +--
>   fs/btrfs/disk-io.c         | 11 ++++++--
>   fs/btrfs/export.c          |  9 +++++-
>   fs/btrfs/extent-tree.c     | 11 ++++++--
>   fs/btrfs/extent_map.c      |  9 +++---
>   fs/btrfs/file-item.c       |  3 --
>   fs/btrfs/free-space-tree.c | 56 ++++++++++++++++++++++----------------
>   fs/btrfs/ioctl.c           |  4 ++-
>   fs/btrfs/locking.c         |  2 +-
>   fs/btrfs/root-tree.c       | 16 +++++++++--
>   fs/btrfs/uuid-tree.c       |  2 +-
>   fs/btrfs/volumes.c         | 14 ++++++++--
>   15 files changed, 102 insertions(+), 49 deletions(-)
> 


