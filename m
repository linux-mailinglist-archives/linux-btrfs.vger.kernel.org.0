Return-Path: <linux-btrfs+bounces-2187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731784C28B
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 03:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9CF1F2388B
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 02:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA5F9FE;
	Wed,  7 Feb 2024 02:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cmb6RfOG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e2/8/GJM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E1FF9D6
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 02:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707273510; cv=fail; b=FtUvXVBa/5ZHnAE+ecZudF8ukg6GLAfVCjCMrFsqUJrglQUYskJdxE2tjbaIOJLfUoBQdSBxrw/9g2uFj22RrOOLgwGcFS/NEVOYssL2IS1BHinc5beWQY7RcyzwaywgNief533sBAVNiL7X9sJZzLEnI5zU2IfOcr4OckfO/Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707273510; c=relaxed/simple;
	bh=1andgBX+MHZLdkfxSKFIJEwJtEbwoK/MthOq59DLqrw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VvN2m7ASI3VLkQskalUL29fWfQV1FbuvdcreCXxar/e6qJO9NgBV2ePyRd6UgcKr/uq0gYwbsvemtJczOtfoAkJGoQEdzIbjh/XxrzI1upnPrgWP32TDT0LfnYsLit1rMQcF3g0hrYZqlmN+YWivdBP6XXz9AyXOz79wA26SNF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cmb6RfOG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e2/8/GJM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416N3jXv006232;
	Wed, 7 Feb 2024 02:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=riM70BffYjVkCtLDNKAkfdBuELA/vBChPpX+pr5LJqI=;
 b=Cmb6RfOGrFkuTk5mPudGsbdEMZKQdHd6PKaqnsIuzHIyESRePdgA6z0vzieliIVStf9S
 xyIbK6mqaVGqW05MJ0QclMgZWWN2cr1mQ1FhiZfhPZyDREIGPDhyCz+JWfxrygHjQfv9
 27v6XfdE9wGPf9CNy/M5+wHCBo64v1L+3vMNl6GXu+PDFQ4tXlSr762zrMPvrpUVY+3k
 bnEqeoDQnyYz+QAI2R5uO5DeShwiV08JgBy1JnUiAz086sgidPfY+6SBwMtRoMIYUZNf
 bNPKhtfP+eib9TzMYVCElyvc442CDU+N7FD7lWPB1W0AaEM2KCetzGJtvqp3N0VhPHFT aQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c940kss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 02:38:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4172KXKj019695;
	Wed, 7 Feb 2024 02:38:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxekrf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 02:38:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRl0uI4bX4eaKsGektl4NFHwXrOBxPOcgKgQ7XXeybQpfOdh+Ih4nsygtZFETWLxrJXPe1H0IiJjN/Z7+ZgKyTSqk5H+q77OlnPuXE1vAT5aKAjf8EorwOkWU1uoA5ABESpYQmwUX3Pl46hYO7epUysMZNnOy+0mGh/B6RmDgNPO8fh7lT1Sa0QnMeoTGWEBgkqQGr8R+KA1og8pOiRE+Xbuix1Stxxx7uxGl6/9YTpvFBNUf7RKWGh2Jj0Rp8fGPEP4HFTl9Bx3wd7Gxl8yffS0RNIwqBV7mZcvfgSvX2hC8zYZGZz1zyxtCzKs3aU5KhLw2tz2bd0hj8z83fNibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riM70BffYjVkCtLDNKAkfdBuELA/vBChPpX+pr5LJqI=;
 b=YGHe76/7xUggbLtl6zqN/1vEyWwpborTvoD6PphALoIbMsqSrL5bYaBx57ycoJxzLtV/jN0TMdduB1sh0/TKKGG+oKOtNwVAXRFlCWKVwww3HtlhSjOu98Hg4HZBdrzY7J+AIrKmp7KJ7Z4v8Tu34NiHffen6DBrO8LS+01+Oz5j3mLTp/7xVcXOx/T5ojavoQzwMmUK0hfVSFmxud7raPUgsOVImqYNmY9XfUEpb/LBB4mRLaeBlzmh1qI+f519UF6DW+dJaMmfTIUVwPNNHgAIPhtDq0/STo0NK+nubd/HgUuC4EWt9DlAGvZJHeJWMSMnApm1Wl4dkvuUmU4sRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riM70BffYjVkCtLDNKAkfdBuELA/vBChPpX+pr5LJqI=;
 b=e2/8/GJMIH9jDX9v1GNQZJk3hNoi8+zx7E3pUh2Q+hQ3oUna9UPAtmeH7jif6g62OBGXbJDEmfO7HDHKXvv3dIiuWDwJS0mOkZg6NhOvbNCiBhASr4AIccEW1z4A3BuvRtzGJ09VLJeMwSczxT73bXBxWSoVzuV9DFGwZwDQfWY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4677.namprd10.prod.outlook.com (2603:10b6:510:3d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 02:38:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 02:38:13 +0000
Message-ID: <e718b759-e597-440f-9fd0-351686bd6b5e@oracle.com>
Date: Wed, 7 Feb 2024 08:08:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not skip re-registration for the mounted device
Content-Language: en-US
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, aromosan@gmail.com,
        bernd.feige@gmx.net
References: <8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com>
 <20240205125704.GD355@twin.jikos.cz>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240205125704.GD355@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4677:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b45e506-7f67-40d4-e8f2-08dc2785d4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	awnzl94ewkc5uAfwlsncxsaYoeMV3zbqHOFUJzGOVa1eoP8cVF54dkW/Fc1DbjR7H8cXfHWGz3WwFRqSSTRAS8JOwg1lw2sQJlUA0XcwryQ2Y12RN8KA5igBixuaibLalbwz3DncA0EsutKXRKZO78X2qVzsQtqWKfoGUpBy5LUGdI9JA2iPsdYaLEnUDKutciRpSHLvTZzbG2xdn46THyoIYsfSMXdHSxYykbvmGSObN1Ohbj9rbLOLYUAWvtkhBvqikPZ+2XxBX8CQKEoJidnn2LnnE+h+5zjRScIJoo8DzCAf9R8Y60wvDg/V4ZvLEpD4ByyTH565PSm3wA2yJrNZCP/Rv6lMV2jb+UsW3hN29rbXbWgPJupZiKM5u53MszQtX4vOgxwlxqpN5eU9+/y77LtWXR+ykVNsgHGbihWb4zQMjc1pHz9+X091ajfVLoL6GVQ9ZmnBH/NPSu8xgF61XQOY2QehpSA7QLN4RZgyJaKnIundE76O9UDZuduE2N2rkbH8fYCCUcH4FbvhRBHYvLFA84YcZnVvmwV+DjkvHNdUILssNPz/0W4TIYrdxIBohJTCE8EvnNzpyGk9inAuj9RgETIIHUw0oVFzZogC0FDW1Fu+Vsso/rgaEIZdiKvD5wWmtMK3PN2RnyJQrg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(38100700002)(53546011)(6506007)(6666004)(83380400001)(316002)(86362001)(26005)(31696002)(41300700001)(2616005)(8936002)(4326008)(6512007)(36756003)(8676002)(2906002)(6486002)(478600001)(5660300002)(6916009)(66476007)(66946007)(66556008)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1dObWFvbWQ4MFc2THFEMGMzdVc1R1Z4RE5hK0wrSFJXbjVVVTN5OE9INUVy?=
 =?utf-8?B?N3owZ09uQ1ZSNFlGWGdpcXR4QkMxdXVrcGU1Tk01YmdkYW9ud05yYVlCQ3U5?=
 =?utf-8?B?L2pKWmFGa1N6ckxTOTdlWUtJMnBma0d3L0FxZk81bFozZEp0eCt1MmVWeDZS?=
 =?utf-8?B?dnNLL0pSUGxYZHVickY0QkVuVXlEc0xpZjF3bG9uM1JxTnBYNG9TNkZndHBw?=
 =?utf-8?B?TzNHc0s0cFlYcjVNNXQxaGp3SUc5QWdKZks0eGJNZ1FaWGxRWnUwSXFDR3cr?=
 =?utf-8?B?SHZsWm5ZTTVWdkdDMDZVSTRxUWI2ZW82MTVLcVpxWWdiaGFwVzhTV21LbHVq?=
 =?utf-8?B?NEh0Rkt6UEdOWW9BcjcvYTRTaGRXUlFYVGV6bVRSY0w1R0F2MThCYVNjbUpa?=
 =?utf-8?B?eTVycnpuSjZrUkNzK1NWZksxc1VoSWR2NUdnVW5NWXFsRHZtUlQ4SkUzMzQ0?=
 =?utf-8?B?SGNBSWZwTURLRGI3bEd5bmZiU0wyb0JlaThiWC9WbGNyNHdET3h1QzJXekdT?=
 =?utf-8?B?TjdTcHU5WlZOTGZ5TVdGdjlpTEU0QzVmMlFHc2lpTDgrV0JWbjdTMmVFR3JI?=
 =?utf-8?B?TE5PNmFKcmhvZmFOckRid0M4WmNneGFsaXF5dXRGRDJkOTQ1TUR0aGtDbTRv?=
 =?utf-8?B?cGNWN0JDMHUrU1Y4Tm9vaTFocXVlYzBuMnJCdDhLYWIyelloSk16RTZZN2tt?=
 =?utf-8?B?anJkTHB2MjhWaFJTSi9qOFNuMXFPWnJsa1h5V3NFRUtTVFJCZEhxYWFCbWw5?=
 =?utf-8?B?LzhwRXJOTk9YNXVwbTlOQ3N5ZkU1K2REU0V4VnhuUWZRZ2ZNRjI5USttZXVy?=
 =?utf-8?B?a2lvYXlNUW1KQ2dqTmk5emRKN3RTRHJibk1zN011eDdCL3hxUnlnai9tcjZI?=
 =?utf-8?B?WG8weFdmbHBVMFlWK0lFZklxTlhsMEM1RHczekxYOGtvaWJvK1lNeDlkZTM1?=
 =?utf-8?B?WHA2dmlVVDdjZjZGeFRiTVVKSmIzWC9EMHFtT1hRdElUVUZKR0lKOTBsaGRq?=
 =?utf-8?B?WUNjeUI1dmtWaHpjNlVsSzVpUmFHRE9CQXQ1V2crSEdmclIvTG45VzEvekFn?=
 =?utf-8?B?VWlZbWpxSERJMy9yUzZIZkFzWEdYcGk4YllhdUlGSUcrNGNWdVR0bW80VkNt?=
 =?utf-8?B?SE1zOEJJcVc1eXJyWEo3dGhnSm8vR3RzbGk5TkQ1cnBVSlplV21BYVRZbzJw?=
 =?utf-8?B?eHE4Z1pFakRFd3hoRzFVd3pQVnBpUmtJYU9SWmJNSTFtakpPaFZZVEk5YmdO?=
 =?utf-8?B?aXJSbzl1VFI3QUM1anpVa0J3M2RsNlNaK0VLQmhTbHlDZHlCK2FrcmZDVFg5?=
 =?utf-8?B?b0pNWDZLRE1sdjc3eE8yNkZhaXNuZkRqQW85VkYvME9mbE9LSEVka1NTR2N4?=
 =?utf-8?B?eGtLNFQwUTRJbDdsWDBueG5yc3prazRJbEowSmE0cTN1THFBWHpXM2p0bVNB?=
 =?utf-8?B?RlhxOWthenY2ZTBiekt4ZUtXNzVCamUrVDVqMXZvTHBFdDB6YWRMQkdsQy8y?=
 =?utf-8?B?aFdTcTJzc0RHazM0OU1ZdzBxZHFhQzg4MStJUm9CRllFblpqcXlrQ3lTYzhr?=
 =?utf-8?B?N0xlZlIzVjRlUGloK1ZENVkxSnh5a2tZbnd2NHVRNlRiUnk1ZEwzTHRBMTdh?=
 =?utf-8?B?ZmNJdkRVNWdIdXBXeHd1UWFpU1JwNnQ4aklPWU90ZVhGb0hiczFzYXlUZHNS?=
 =?utf-8?B?aTN1L0FHWW5WdmFDYWZnS3hoY1premdjaTIwZjZCckRwdHpqTVVCanpwNVg3?=
 =?utf-8?B?a01qbmpWcWUwTndHYmk5RCtsN1NQbHRyZCtFYUpvZjN2SHlvdm1EdFVnZThT?=
 =?utf-8?B?VTVzWWw4VXlmbGI1RnFJSDNQK3MwUG5oR0dhWDdQNjNnUzB1WVFyQmc3K2VI?=
 =?utf-8?B?YWZXME1BL1N0VDRsd2pxSi9qU2hUSFFLVm5NNHovNUV1V3JyalJmYVVUdXlr?=
 =?utf-8?B?dG84ZGowemloaGlnUmRldk1zVWNYa1NpMi90TUpvNnlTdExEdW1hY2ZUZkFx?=
 =?utf-8?B?bWx0RnN6WjUrRmFFczBpeFY0R05CMW4vOEN5VGx0eEZxMTIxMkdZdzRhMXlL?=
 =?utf-8?B?bTNYeFVvTm9ici9SREZCRUdaTWZENCtrc2VMZTgzUi9yMnkyMzMrUE1ZQ0wx?=
 =?utf-8?Q?Fa1XjPRxfRTuk20x1njiG4TcQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OMykcjKK81x4BFOYuIgIhd7L8OPxf6YhwYk9HsAeVWgSJ8+Jg0F5YBL5S+EYan9F3LgiYVy1+jqtfra5CjfczThL6CTib7AxLvgec7RxxZGSjFR573sNKhngQIbz775zE8UUQvQukNC+EFFcYd+Tssds8y9+v/wvQj66YFPRnuiJZ+U6WNkIuyDvcH0l1uNhzxYh5HUEMdvH1bEn9cuMScqkYxHDs1dliUTtFRFleNXqQUQMf6AP4VnQhQqQIu72QBw4kYTPEfL1NeDM/rTfS/RYPRZWP5QPi76831HIdf+j82CVKpwtdnVAvQ3tHxmUzI9vtmxC4oSkNZQjWETW8gKUuwrRvqWzk/zN4v+wpjXKzjgTlm9GNvJdWDTnyNefWzxHBBCwTPbyyJDZ12x+LhcpWItzLbJXYx0LeWaC2MHh4pt4Kv74Q982y6QDoeBVQkrSXxvHgdyM8XQFUldFWbJKlUk/r/HmYcjrp+tgtcurIdPEpZ6pW9urhtmRM8m3cAD4tOAEX9trAuKaTNwR+7R/v2P5+WaoIRSTtvDYWdIunEWDklvWmGjgtTirlG5HcRkLU43BrrrmOUsMa0hIokLulfUiIhsaPxiK+MFjslo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b45e506-7f67-40d4-e8f2-08dc2785d4c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 02:38:13.6823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3fq4UfcJrqqIRwm/+zwfGtD63NLOGj32aVoAP9Kg18C/QNUC7oNDuXiGNVckUcvBipg1sBcpfOafHQZQfDDTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402070019
X-Proofpoint-ORIG-GUID: GONK8bmU9hbhLIamNJKGXLqfy-1zmWz3
X-Proofpoint-GUID: GONK8bmU9hbhLIamNJKGXLqfy-1zmWz3




On 2/5/24 18:27, David Sterba wrote:
> On Mon, Feb 05, 2024 at 07:45:05PM +0800, Anand Jain wrote:
>> We skip device registration for a single device. However, we do not do
>> that if the device is already mounted, as it might be coming in again
>> for scanning a different path.
>>
>> This patch is lightly tested; for verification if it fixes.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> I still have some unknowns about the problem. Pls test if this fixes
>> the problem.
>>
>>   fs/btrfs/volumes.c | 44 ++++++++++++++++++++++++++++++++++----------
>>   fs/btrfs/volumes.h |  1 -
>>   2 files changed, 34 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 474ab7ed65ea..192c540a650c 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1299,6 +1299,31 @@ int btrfs_forget_devices(dev_t devt)
>>   	return ret;
>>   }
>>   
>> +static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
>> +				    dev_t devt, bool mount_arg_dev)
>> +{
>> +	struct btrfs_fs_devices *fs_devices;
>> +
>> +	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>> +		struct btrfs_device *device;
>> +
>> +		mutex_lock(&fs_devices->device_list_mutex);
>> +		list_for_each_entry(device, &fs_devices->devices, dev_list) {
>> +			if (device->devt == devt) {
>> +				mutex_unlock(&fs_devices->device_list_mutex);
>> +				return false;
>> +			}
>> +		}
>> +		mutex_unlock(&fs_devices->device_list_mutex);
> 
> This is locking and unlocking again before going to device_list_add, so
> if something changes regarding the registered device then it's not up to
> date.
> 

Right. A race might happen, but it is not an issue. At worst, there
will be a stale device in the cache, which gets removed or re-used
in the next mkfs or mount of the same device.

However, this is a rough cut that we need to fix. I am reviewing
your approach as well. I'm fine with any fix.


> 
>> +	}
>> +
>> +	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>> +	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
>> +		return true;
> 
> The way I implemented it is to check the above conditions as a
> prerequisite but leave the heavy work for device_list_add that does all
> the uuid and device list locking and we are quite sure it survives all
> the races between scanning and mounts.
> 

Hm. But isn't that the bug we need to fix? That we skipped the device
scan thread that wanted to replace the device path from /dev/root to
/dev/sdx?

And we skipped, because it was not a mount thread
(%mount_arg_dev=false), and the device is already mounted and the
devt will match?

So my fix also checked if devt is a match, then allow it to scan
(so that the device path can be updated, such as /dev/root to /dev/sdx).

To confirm the bug, I asked for the debug kernel messages, I don't
this we got it. Also, the existing kernel log shows no such issue.


>> +
>> +	return false;
>> +}
>> +
>>   /*
>>    * Look for a btrfs signature on a device. This may be called out of the mount path
>>    * and we are not allowed to call set_blocksize during the scan. The superblock
>> @@ -1316,6 +1341,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>   	struct btrfs_device *device = NULL;
>>   	struct bdev_handle *bdev_handle;
>>   	u64 bytenr, bytenr_orig;
>> +	dev_t devt = 0;
>>   	int ret;
>>   
>>   	lockdep_assert_held(&uuid_mutex);
>> @@ -1355,18 +1381,16 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>   		goto error_bdev_put;
>>   	}
>>   
>> -	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>> -	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
>> -		dev_t devt;
>> +	ret = lookup_bdev(path, &devt);
>> +	if (ret)
>> +		btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>> +			   path, ret);
>>   
>> -		ret = lookup_bdev(path, &devt);
> 
> Do we actually need this check? It was added with the patch skipping the
> registration, so it's validating the block device but how can we pass
> something that is not a valid block device?
> 

Do you mean to check if the lookup_bdev() is successful? Hm. It should
be okay not to check, but we do that consistently in other places.

> Besides there's a call to bdev_open_by_path() that in turn does the
> lookup_bdev so checking it here is redundant. It's not related to the
> fix itself but I deleted it in my fix.
> 

Oh no. We need %devt to be set because:

It will match if that device is already mounted/scanned.
It will also free stale entries.

Thx, Anand

>> -		if (ret)
>> -			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>> -				   path, ret);
>> -		else
>> +	if (btrfs_skip_registration(disk_super, devt, mount_arg_dev)) {
>> +		pr_debug("BTRFS: skip registering single non-seed device %s\n",
>> +			  path);
>> +		if (devt)
>>   			btrfs_free_stale_devices(devt, NULL);
>> -
>> -		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
>>   		device = NULL;
>>   		goto free_disk_super;
>>   	}

