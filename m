Return-Path: <linux-btrfs+bounces-125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B749F7EAEA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 12:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62151C20400
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 11:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AA02377B;
	Tue, 14 Nov 2023 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B2ae2dNn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xdt5peIg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E9C224CE
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Nov 2023 11:13:28 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E508712C
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Nov 2023 03:13:23 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEAxHKB020258;
	Tue, 14 Nov 2023 11:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MTF6T80EQl3/eY4xEGt0iJkQNYvJA8GSx8SwtVOXmKE=;
 b=B2ae2dNnNQ074qveR/AY2jPyW4MIH7Njt74Z+k5qyAzfeU6mZzVTMa6/8PzPAJsGc2hQ
 KFPxe0DbLhXQpjTq99NN8VOST7WtfOxR0j7R51eAUenJtsPZ98XCtQRNRB7amiph/ixt
 hx6c7fkTeGYEX/PhOl7k6UItJGlJzUmbH2jUgzBZsRiMzI8SCZgoQsQUlDkcI3wsD60I
 0wvOIKat5t55xpegNdyo87YogJA+m57vbVHMhG7JExmSuGafjHOezzJmTrWLYxlRkvbR
 bXTgWHc8RC5Kx5+KH2+krasQb3V/nBF3eimcpWQdj2l/Qbl+R8Apwc9OSgP9TNNPQvug ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2stn9rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 11:13:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEB6K4O030206;
	Tue, 14 Nov 2023 11:13:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxj1u53u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 11:13:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il6jDcgIkCSdKtaNDYnImUzQmN0DeSGX0sP9bWRw9rswcrQRDHPnAffQC4Fvhlyu7diW05yWVFn/h6Xk7vJqFALVMNiLTAnFeso0haxXaPHys1pn9tIn+nN/a5i/Shq3B8DwGwxZSvjGc62DG95fcPp3c+T6LcQeWeMddTHf+PIj/hwBmomat8/8U17dgQurShUKIl0audAOCZgXsw6zK7n3gh0ztdjVtOEqr4QXQ3Ob2HZGa9RGwB14emDJrUDjj4chlErfIsSX0u/RCZNcuprmDO23chyxbMIF1eze8cCLow2vf0WPQzcoJ2F9lTOjG93doZCqRmUcDSBsUsCWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTF6T80EQl3/eY4xEGt0iJkQNYvJA8GSx8SwtVOXmKE=;
 b=WLGlo3QrbSYvudi+e0dQjG5b6EKnrAI4oPLts2dDM5XScq5t3ly2IR1xKYTf+QvbU0zFEsyXK2VklVH+t0Ke+ovo8v741qHd0auHaI+KdLzUXYWanzOMifX1nmv9OfpliEFU/QcrXPL4qfN44H5vrK77xaUHw+l9/ZlsvufDEQm1r81FpoWPOFpJroS//KHf2BA0q7VP2Y2rYY/mhSDDznEs6nnbF9thiV+kyxp/oCyD7Imh4u3XATXyf/YT6ux6TIkOtfys7LZZoYqtN+yLi3p0uT4BMkG87RrDajYkqUChliZeJE1hLBXo+7fWRAosag5fdYLPZii+kZj0GfUt4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTF6T80EQl3/eY4xEGt0iJkQNYvJA8GSx8SwtVOXmKE=;
 b=xdt5peIg4RmGHwMLnMzK+IcBBcfNYczsNj+9+0En5dn6CLEUHHJr/ZGoZvyXsvcf4HfAZz4T0wtl5Tp7mJ9PbQ8ufoUn2PrYuNGNfKno7vI2LaGl4sQMNvuikK2E1GeSle1a4r1hiSs2yyI0/YHDxfeibJc7xhDhYLj5QVl5GkQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5814.namprd10.prod.outlook.com (2603:10b6:510:125::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 11:12:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1%4]) with mapi id 15.20.6977.019; Tue, 14 Nov 2023
 11:12:49 +0000
Message-ID: <80c99e71-363d-4e7d-860e-fc20a6c21492@oracle.com>
Date: Tue, 14 Nov 2023 19:12:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add dmesg output when mounting and unmounting
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
 <20231113174502.GX11264@twin.jikos.cz>
 <83b7280d-6396-45c2-aa5e-fcd1f6f44963@gmx.com>
 <20231113210933.GY11264@twin.jikos.cz>
 <bfe5ce35-1bbf-4eb9-982d-30d52bec90fe@oracle.com>
In-Reply-To: <bfe5ce35-1bbf-4eb9-982d-30d52bec90fe@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d183df-b66f-48d2-94af-08dbe502a328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dSecbQmSCPCCFB+ybooUFpvQhwNruPQDMUvWzChXilHF/ViSF19RMLHAOF+gmVrvrA31TSkG27Y1r8q74s3THagvGqRZm/lm+58vqiQPVfoAOgr1VC2yUEvZNm9EGo3RFFsrMkztBbfJciVo0PYnVgObpGnRdqruCvf5E2T9b3/byN23QNvVAe/228VoC7KzPsLUW3g+1Yo/gsSqL/2JbAXXNI/Yahdqg1+qsP1DQDzKw6/S81M9aiONb9Bw/gq6FsnzB/13UnoZifr3xRHqWbBvboQ4cyQM4MtIeh4MqG802l7K2Pv5YhBd8Pc0UKCUhNE7y1+yO6o8t+XXnGpteV7zX0IdtAsyU+5pKQw5ybMfI2lnonBDJy1QAanAEuzxJOb/tE9xtDR3jS1Ep+tiaDpouFYWUbfGZtCQore58becNqC9/h3mdGoLh5ie/zGqYq4kpg4XZu/mD5xa7chGZcQ3YmEWp0BdRzU4kb3KpIaIwDCqiO91y5ribzUiJdeSqy/cCUx8zCf8Hvj45sHwF2h6B7TPtS0JOXng7ue1Xyojwk61uYBN5Qluuy5aypSva+BzM8u7k7MPSLLRuAod7jkYDROoPF14b18OizP9uWGEg+93+7VS19lOyQU6oeTy3HoT6XHK5/mSeG3v0eZbNA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(38100700002)(86362001)(5660300002)(2616005)(31686004)(6512007)(6506007)(53546011)(31696002)(478600001)(6486002)(36756003)(6666004)(66946007)(316002)(66556008)(6916009)(66476007)(2906002)(8676002)(8936002)(4326008)(44832011)(41300700001)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2p5Q1labXVyWHJzcTdDU1lzb1ZLbTRRS2ZXVTI4RHFxcGtGSjVDK0tLUXAv?=
 =?utf-8?B?eHhZUy9pZjRKVkRuU1V2cUQzYzg4ek5nZHJqbUhpUzdtaElFZ3cxUXREbUxB?=
 =?utf-8?B?SnVWNmpyZEx6dzJ4RVdKNWtkMDEwSWsvVXl0VmRyeGtJVzJCVFBzR2ZleGUx?=
 =?utf-8?B?alArZnhveTlhN1B3ZmhQdDMrMEhhcnNiQjNqMDgra1Z4NWh0elVJU2d1ckhE?=
 =?utf-8?B?MkhkckppRmh2OFFYOXBzbTBEbjJPZE1yNE5mZklQUjMrR2JVQzZpUkJyemRi?=
 =?utf-8?B?UkpuNkJjRjQ2aFhmZkFqT1JCSUJ0MW16VXJQb0lkRUJvalpqZlphQ1RyNHpS?=
 =?utf-8?B?K2ZKSjZ2Y0RMbkdDSUpxZnQwSkpldmpHZkRSNFlVSUJYNGJ2UUFkMjdvekt2?=
 =?utf-8?B?QzUrYmxIS0JqMFFtalRiV0NVWU95bmw2ZXlrL25ydTlCV1RIQUZVS1cyYmo5?=
 =?utf-8?B?VWpHWHdydGg2WitWV21IK0VwTlljcnJZNWJoK0pWL2wyNUV2STdOcVI0YmdB?=
 =?utf-8?B?VDhlOXRkRHhjSU5jdVBEOC9EK2VQTnIwOG5ZZ3kwOWZGeWJOeEZhWTVLWVl1?=
 =?utf-8?B?VDZUaVlLUU14MXVNeEx5N0hvMnFBUlQvL3F0WU9ZTW8wZ0VHQzlvNEs1c3Z3?=
 =?utf-8?B?NEVnN2hzYVB3UUlwZE4zaXoyYkMwUHBrTFNLWFBsZ1ljTEZEV1o3ZW5jeXp4?=
 =?utf-8?B?VUpRYjhYK0F5UzNKNmpIdis0UE9VWmtTQmhaT0o0RUdhaVAvRTdlZHAxbFJq?=
 =?utf-8?B?enpYZDAvUTRsWkE5KzFFbnBUc0p4UzBON3MzanIrT2prbW5qRDdUS002WEdu?=
 =?utf-8?B?ZWhqTk95c09paFlodG9xRG1qd3IzZjBWNmU1OGRJQ1JNNFRsczhzR0s2QWNS?=
 =?utf-8?B?aTNXVlB5WHNScHNlbll5MkxOeitGS2JwZnFUalRBMzZ6dWx1Nm0vemNoRnZZ?=
 =?utf-8?B?bm81c0N1OEJLMVpCZlE4NnYreEhzQkNrNzEwc1JiVmhvd0JRVEhtWVlUc0p1?=
 =?utf-8?B?K3MySVVjSnJBL212Z280VnVveXBacGdEd05pOUpZaERXdzdQc1JNYXhELzQx?=
 =?utf-8?B?NWpZa200WU5XVUlVMkQyanl5dXZucE5HcWNJekJuMzBDOWQxbUZKQW1yQTlw?=
 =?utf-8?B?NkxJK2R3bGE3QlduVlNYdkpuSGRmeDlpcFNjOFIyZE51MUZDNHdMNVpmSkRu?=
 =?utf-8?B?aFNZWDNtVVNRWFcybjFoZWw1TTRwMmZrTUpOekR1OHNpWnFkZjM3MElmZklY?=
 =?utf-8?B?Yis5ejdrRWlQaWVZeEtFVG1rWjE0TW5uanFYaTNjQ3o1UzliZDBScWpka0oz?=
 =?utf-8?B?aVNCcm5FdGVkcWZTdjAxaC9hbGh5dFRMZGFHVkI4Qk02QmQ5b3YrRUoxTkRU?=
 =?utf-8?B?eEFnMmNBWVJudDQxNXFNclA3Y2hiOHUzRnpneTVJci9xeUhSaUdmbFdMMWQr?=
 =?utf-8?B?bzJqMXdENU9jalZxMG5TbXZSVElIZDFhNmQvWVBlRG9QQU96V2lhekVQdjFW?=
 =?utf-8?B?TzhHRGdXeHQ4SHF2QmxnK2RMK2svMmQxU3ZCR3dOSFZYcnNkekExZmJkSk1n?=
 =?utf-8?B?eXhGUDl4dUFFQi91cFZQNW00SldjT1I4OW10RTJlOTNwVnJtU0U5QVoyS2s4?=
 =?utf-8?B?Z0l2TXlRTHpkUUozYmtheGtxK1BPTTJnTXlFRXcxMEN6OHVlSGdLRW9LVkhF?=
 =?utf-8?B?by9sK3dKQ2pKSDR4WDVWNjNHVTg1WnNtVE8rZXNLU1NNRzM0RHRBZGF3U2Vl?=
 =?utf-8?B?elZPUEpOR0JyS1pJK0RId2h1QlBGcmkwWXR6OTdnWHM4a2IyZ1pKUjhPOVZv?=
 =?utf-8?B?aTJtQ2p2S09CY1JVQ2JWNk9XaDQ5a05lK2pTMzlyYUtKMmQ3dzBOcThrSWE5?=
 =?utf-8?B?cnJtbnJLUytvTXpUMU9XaWpaSUxlb2x5OVNmQWM0eWk1ZUJCRlcvMjVQY3RV?=
 =?utf-8?B?Q1ViVWlsRzFTTU9HMUF6eG1KS2xlMHRpSHFuZEhzNGFxUUNKSWJLQW5OTS9h?=
 =?utf-8?B?UC96NmdEZHZabk5DbmdJTXFqNzA3QmdRSmxSUmExWjJOOUdmK2FXbmtGRlZs?=
 =?utf-8?B?WjV1dnNvc2dLK2kvejZOMXRLdXNpaVkxS0s3ajlRcE5iRGZBZ2RlREhpRE1s?=
 =?utf-8?Q?+KaZxl0plhBhjA8MZDLzCIQdV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	U38IhL0/z013THOnMTe1J9QHJzyuK+Ruq6pif2wuW4l3xUGolN61QqN/uxjgNnLpY5SPqcj6KhRivePS+i70xm3ggs+GwOP+5FvwBMYq1Bi6WwDmFMAVpF0+g4b8xwhNVbwM0U7dBhLxufol+8TtP/GX3lBn9zAg7h+NhiqBGxBL5RVCTF6jEVYlAuI3iUf2N8IVlyhInVgQGrHyBJXyWuY00invxYUJf1FXK8eAdJfCfaNMB4t/75a50wdOx0xDIm3NQFqa0g8FmAUWieelNSVVGgbLU6iu+yfjwF1aqDh5mQKjXgMnXwj25iq6slboO4xV9oMzcZDdnbskHGwUPCrPLPYBmLh4QVZDcwWCWOrYZGO9Gz2l0Oo8OXDjFgXfCiofAvdlq9hlCQb0qLbYb4dbyA16rHn2e3PFlV94E9Bf4DZBbmf1tzS9sS1k6hILOnnk1eZWcdwwbBHkHe5bLJM/38T8ZOBdUXMsNOZGiD6Vxrt2YplOeHKQt32O8GG7nf6OMtJVNPZXPQohrkDeQrSgPnHLTyE9n40bR/eUNhR4buXeX0+9QAafcm4TQhkRDefvs5iuU8tM5iCju3xHRgsozjGJBwA3fpt7mmxhqnx70CuvDlvWmKmf6y8QSja7msb36WlEC2+3qZ/4jEG6uKi+GbWrBWaR57J1Ex6KK1SG2qMpEX2kdxdssFuqbYfmPA5h9J8/5bZk+nvPUiYv1v12tHwSwPs9mCoSXhwSSWPrRWhs7O6ureFxdNrjhTxNAGgoD8luzLvBurr5OPPVGfKCzMF2/I2G5ffhqTqtv0aNgYPEfCr3yAllYtY3lSmnVAErSdWjwil2hMbuXg/CDw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d183df-b66f-48d2-94af-08dbe502a328
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 11:12:49.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCuF3q7i8qItQ1GP+aCo3h9iZX1n8u7UmcHcd8f8pPgki+E/ns6Pb9jjyxhDulLNaDIbMSlo8DfD3mHZ8cp+Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140087
X-Proofpoint-GUID: 3IbTfCCNRFQ5g2MQz94J1beM5fWLamVd
X-Proofpoint-ORIG-GUID: 3IbTfCCNRFQ5g2MQz94J1beM5fWLamVd


On misc-next:

     3212 btrfs_info(fs_info, "frist mount of filesystem %pU", 
disk_super->fsid);

Has typo error.



On 11/14/23 08:38, Anand Jain wrote:
> 
> looks good.
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>

