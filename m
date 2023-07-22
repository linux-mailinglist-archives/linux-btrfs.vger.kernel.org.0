Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC5775DBFF
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jul 2023 13:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGVLu7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jul 2023 07:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVLu6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jul 2023 07:50:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD7A2D45
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Jul 2023 04:50:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36M1uv81021605;
        Sat, 22 Jul 2023 11:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ecVxMy/n9SkFEKHRhl9q27PbSWXCoPvpOx7nCcuiTQM=;
 b=aO6qKNKgwColhsyJNKtHSOJkJ0PWTY/ULZrWtkDsk6xnL5aubD+OgPqjuI/hAChiE+Y2
 smAXjHwKjOvzAeh0bJiKL60L6ylNnUudwiphtnED2bTQ2UZYT6LZRGVMElTRttHB8XVL
 8rSpgM47Lp6FOpRaAMTEF5TWkXtEWuZiPO19/ZfqRW5wqJXteb/GxnYtNojhWHDvmocL
 gflHlAMhFPP5SbRboKRwpf2OpOHNpU2k+0fLDdsnQy50t+Wqkbd870e5GXvBf8g9zlJt
 wOq6Yt9IO/u8cVP2CvvAKn8XVYPeb7miN3yrhPYVrRZqQNPQcAoTJE5S3rfDFm6moIyl Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3gdvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 11:50:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36M8Zvjw029268;
        Sat, 22 Jul 2023 11:50:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j82ygj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 11:50:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcmRLIhadIpgpfMHWCXGxC620CL/SopO3S3Ort9cPmed40kQFVtgU+RmiRmiIispB4FlG9yW8pnuYz1E5baC+J7oSb05a8xRUwuWLspGDZvL2xEqtiPC3b1/aaXLQk2b2k7siGMtE1jpazSaO1f368hyKw8yOBC+SF7oqbkFAU3kNJtluU8h+WsTVBGygEexj3+HGNdNot47u/rHmOjFliEEdb9UALm21B26YwaFNwa5WbbWuRxsVpF3GPfDoDyW75l6Za7ichrDq2ZrArWcogUrnsuEpeUKtn0Y+mMBR+DIfSXuflPpN2cLNzL9yCL4XQd/WZEtX9vijqksC+B7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecVxMy/n9SkFEKHRhl9q27PbSWXCoPvpOx7nCcuiTQM=;
 b=Cjgv/Y19/eOp0Lh+xts7RORkN4ARNFHYsgccGvdj9p5s+WRJGLfAt9dN7NE2w0Y5qDdHqauINl7kExo0ICd+CxslgIPBxPCSDdMQUbXo6xS6K6o3E2KP7HZphitRB3qVA/Fn9YETeITZnYNPhNUn1qbW02v8Z47LEGRudS5prwQXlKR6s+u0+WlTD/P6SNxpdtuJNhbcI9NKyiQl5QbnskPk55Pz/sj00QGikqV//vqFBFShhDr/GUDXyC1JD5BmkVKkproh6UwPJNBE+jkCiVw1dBU5dr33/AEzTxpNHHSEDHlP1kzLtnkF5lQ6vs4iJA6ATmMzRdneDY8ordhxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecVxMy/n9SkFEKHRhl9q27PbSWXCoPvpOx7nCcuiTQM=;
 b=x24eqsG3ALM+W1ie/cx/cdX6yxQkXiRZer+tDhclHVq4HCuzazDO5+cilO+vtaYxUAZe0wFO2ZV3sqCPCmRmrY+uMi3Xmzfl/bsBuGr+LC+fYK1KyX+kYVr4g2oLps8E1C7gOdQ7yoi+inwgFFyOZlts8ULf7D/bvRXLnt0cDGo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB7469.namprd10.prod.outlook.com (2603:10b6:208:446::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Sat, 22 Jul
 2023 11:50:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.030; Sat, 22 Jul 2023
 11:50:47 +0000
Message-ID: <f13b2a96-a8d2-0e4e-3667-ee76e4094b9f@oracle.com>
Date:   Sat, 22 Jul 2023 19:50:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: race condition mounting multi-device iscsi volume, not resolved
 in newer kernels
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>, linux-btrfs@vger.kernel.org
References: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ced1958-0678-4a0f-a04a-08db8aa9e2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4wF/B6Vm4+gQfN+AltmUFIlwmDrmLKIMBCVqYiSDEMbe/5l96nkLPZGhGL2FKZIAHUAEljaAO6HA7rkyrTiscn4S2CyElnKrlHwiQ6UeMJC2lQ1LeoHLuYa/ChlqYoTxemSFd0AEpHtMNIj9qxqkTF8rgRROf2GzLdBHn+wu3ScXReM/TrI/07nvmz/llt+ZPutJxRhyot1Jpnm+55TKiweGoI3elkLv4e4bJmy2Is3hy/xxbM7+PTj9Xx13by0aeQi3FXj9/2+oPnghBUTwbCmY9o62ek2ZZKi3qKgYpIGeMggKlTjzfCuZ2WmZ2CLXMYDZsUhMZoZ6CmVOEHq6oNaY+2owDVAnQG5AAOAZYEIU87MLibmbgUZWZTJTZk7OQOcfgoMGscDfhZcBf/zeb4/K7fHf1un/ZnL/t3uAGcgyOLBdDr9j8d8yM5Qwkagyyvkw7jLLJXIj335rglxZX3ERu+Xi8SWSZ73dhpWgDD6kyJhh7myjSUblZbwluYmd5R05a+zqTNVTIyywsl9dhCq+JY1qBK61juhXS8I9F45Dx//Ao2aoKhKHf9y+wd9Lbx4znO1IjcsQKhRCZreaSZSg9r1miQxPHvcrw081tTargxWyyYf8hT9G4COqjKcIgqfLC9ytsDEJr+DN8hUsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(6506007)(31696002)(478600001)(38100700002)(26005)(86362001)(2616005)(186003)(83380400001)(2906002)(6486002)(6666004)(6512007)(8936002)(44832011)(8676002)(66476007)(41300700001)(84970400001)(5660300002)(316002)(66556008)(36756003)(31686004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?end4MjEva2pidlFvbW1lWDdrb1ZYa1Z6YnhoNGtqVlFWWUlzMm9DK0JURXdi?=
 =?utf-8?B?OWFHbkcxQzVEYTBsdXA4SEh6WkNscHVqYTgvMUEwSnlWSVMxSllJZHJoUkZV?=
 =?utf-8?B?RFQyUDhDVjIzZVJZbTk4a05Oa2tsVXNZeUN6Q3BXZmdMNHI4SkFrRS8zcGsx?=
 =?utf-8?B?LzU2RXgxdkNsZUFzcXNFMy9PRE5FZkhHUktGOUdnOXk0U0lNUEZPZjBYMDF2?=
 =?utf-8?B?NVlpUlRMZEJXTHgwbC83ZWlFc0dpMC9wNEpjOUhOM0JiSUJ1STNnelVRRlE4?=
 =?utf-8?B?ZzBkNlBQS3RMNzJjQ0FYdHZYeitGMzZMcGR0S0RDRWZrSWs5QytTdk5jdUdO?=
 =?utf-8?B?K2Z5dngyekZ3eHE0eXVIUGVaRm0yUHNJUG9FTFVLTFpIMnNTcDNwNWxiUm9G?=
 =?utf-8?B?NzNSSDNlaXcya0daN2RSZy80VlFxcjBlb1ljdS9BVlV3ZUdRWlhnWHhQT3lE?=
 =?utf-8?B?Q0pneGpCMUxLSW5XaXFub0FrUlFTTFNSUDZkeDJYYk0xRFZ0UER1OFlGeVJD?=
 =?utf-8?B?SmhtZFVUZDc5a2d5c2NlRldmQzgxdUxtWHUzSGwyVFMrc2pFM2NkemQ2WUt0?=
 =?utf-8?B?VVJNN21mdGVhaHNTekh0THNhTHdad3NvTVZVUmUzNUFoY3phQ2U4VFM4QkVq?=
 =?utf-8?B?dDJpdTVHQnh6L29vd2hJQ0Q5a0ZqVEtleHdJcWY3YWdxeUtPNmt5d0FjLzc3?=
 =?utf-8?B?SVVZa3dBUWFpM1RGNFJDcWk3Q203dXJLdE9YWWp4MHNDSlpOOVNTcG1wZ1Ft?=
 =?utf-8?B?NkprRWYrVk9xeWlBMWdSUkw5dzZMVTRRTFdNU0JjcEJ1R3ZYNkI3MW1iQ0o4?=
 =?utf-8?B?V1NrVXdnOEx0QmV4VU9mZXJ4Q2dsSXhlTGlUUzRXZVNxVmlhUlpHcjl1azA1?=
 =?utf-8?B?Y2hpbEwxaGpsVXZUaWk2ZTJZQXV3eXFvcFRUNGlvRUd6azNEQWRpbkFnRGdl?=
 =?utf-8?B?R2VISzFwZmIzajk4U2lsY2lVSC8zRitWREh0a3o2RXpKdnRTNVNUMzhkbTRP?=
 =?utf-8?B?ek53N1FFUFh3MGlLMmxaQUVvcHR1eWUvak53OFVkMzI2MG54ZmRuZ2hnaHcr?=
 =?utf-8?B?UmxqeEVlejArcGFKRUpvbm1kTURpaENnc2RBb3lWK0YzOVNGbXVCcGh0U3N0?=
 =?utf-8?B?MmxkdS9DTzJhSGJqNjV0UFJtcnVVNHpkdElzZkt2NndDK2ZlNzBFMENiamVO?=
 =?utf-8?B?dnByU1FybjdEanFkd2plcFhrbWhhcTVuYy9Zd2hGaUMrT1ZJTTBaUDAvSmtm?=
 =?utf-8?B?Yll2MUF5bk1ObEV6VDFHWnFON29BeGNBTU82WlFoT0owalZHcThzdlFBaWxz?=
 =?utf-8?B?cmovV0xTWkovMGZuMWhadU9SYTJlTU03K1JmYkRXWXhXcG5uMm9QeVA2UlE4?=
 =?utf-8?B?d3lGTVlvbmh1aEx1OGU4WU16b1dkWUJDTkQvSWFXS0pHbGg5QWUvVURUQ1Bv?=
 =?utf-8?B?RUorenJRbG5qbm5EeFBvelAyQVRsc3R5S2RDbTFBLzJNRnMvM0hDbk8wZXY0?=
 =?utf-8?B?b1dNUGZvVzI0YzlHQUFteUVaR216TFBVcGRMZmhxSklETGxZRngwRGM0SWtC?=
 =?utf-8?B?enlJKzk4QmFyZFI4NWRtbGVFTG5nMG1nMUphRGROMllSTTArbE9OQjB5aVlH?=
 =?utf-8?B?eU05UlZUQUFtR3VjN2h5VVR6YkZ4RGE2cjEvS2lVbkVxZFM1VTBNd09QejQw?=
 =?utf-8?B?OG1ZZlJzL0lPVDE3TVEvV0UzWUloVVp1NWxyRy8xWXdIYnZjd0h2SEwwRnNY?=
 =?utf-8?B?anhJSkNNcU93SkZsRFNkYUpGOFVUbTBiYWc3VGNLbEZ0R2VqMnljUXdJNVN5?=
 =?utf-8?B?a3FkaXBUWENwd3BJTW96ZEkvdytrejUrYVduUGtkV0EyeTZFMkdndEpObzA3?=
 =?utf-8?B?NWsrY1VxY2VlZzI4VEFYbzdIUEIzMU5yVzJBR0tNdysvbVdyZjVsVVA2RFZR?=
 =?utf-8?B?NWY2SHFjN1JGVU1yNTlkVlp3UkEwTHFyRnZ5UGRzdDBUVlduT2R1MUswdUFv?=
 =?utf-8?B?UDM5LzI0NDhsdGFlSWR4cVczdnVGb0hpOUxCSE83RFQ4VWxyMVZyTEg0Ujgz?=
 =?utf-8?B?dGNYMTRYMEZpaUVwbzZmKzNhMlBEa1lBb3dkR2MxT3ppUXhTby9oMGZERmJW?=
 =?utf-8?Q?p3Vz5D92cVVsTrEn7DtioeFyi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TSv28jwqhhM3qwP/ZKN8J+9vb4PaCIUX/RnjTnkPqpB7PKHnp9VBxYvFfi+pa6/doLX8GGgW1z95Kqu2QMY/M7TRpNRArVBiEX3pmqHqsp4CT18OmNp5ksucrOCnCLTRLYyj570gw8jSdXF4rPZ1M6s3UX+uxDaJmZCBXb/0MzNJWUP/2lOVnTj7/X3qfn/UXdjCcCDK/cM0nafsfsSBImh8s8RWyYHY84iq61bJEwNhT7dQNZ5KOGhfRg/tonjn19bJ50HUEI7izoR+soO2gaXl+kzTtdkg2TRCPpY6XLxA8J/pNCXu0Vk5QWIHmPHRrwWhOeCRDtV2WfUOFwGvruY2y1lvXzidTx6JrKeTSZBya5hWLD0pEFtzleKlLmJTnQ16VpdGSzN9zkcuobHVuA5P0eilfjScPA7F2icswJOTjgVKmoxp6dwjLjxppkJWPTOnP+wc4DNghYAB3glQN6WdMUAspzAFP4tEskD0nQimY0LuvofV2Q/Xzcfb+iq6FDt0DdvxE8EjK/KCpr2OhMRfHk+BOP2OEMZnxqTCjXh9AU5nHTjSahPEZO47RwU/jm8m0ycsZz82i9wgJT8YLp4UzaIUCpfs9pyHZ9gPvCk/lq7Tx3iATjHUWBFwiLYqxREQPzd7AGYjFwKCGaSwmLt979bOT9+8zWNBRgmBWpiMUue/gFimfaQGRMMCMEzaefs5eUXWFUx6C1cqXJpGr4odcETZ5QmfnmdHHTo3nKXomc3uK6jp5SVVvSLMVWnVj24SckqX9fPB+qz1oWFfhj+5CcWyk3p3FsBZOmEb9eU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ced1958-0678-4a0f-a04a-08db8aa9e2ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:50:46.6587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pwbk5uE4wNjQ43HCiM1NFsiovZML7AnJT7oIxvy0FIADubs2buWaUbYTJX5o/RMt+d7VD43mIxxL1qDBzybkLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7469
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307220105
X-Proofpoint-GUID: TBPw6Fqc-J98W7j0WPbHkcmhTLOTOS84
X-Proofpoint-ORIG-GUID: TBPw6Fqc-J98W7j0WPbHkcmhTLOTOS84
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> After learning that a patch for similarly reported problems had been
> submitted in commit 50d281fc434c, I further tested with kernels 6.3.0
> and 6.5.0-rc2.
> 
> The general problem has persisted even with the newer kernels.

  So its not that commit then. Let's see more.


> 
> The system is Linux Mint and all kernels are Ubuntu mainline.
> 
> Mounting is possible manually after boot,

  Noted.

> though the mount status of
> the volume appears to be left in an inconsistent state at such time.

  Hm. Do you mean the filesystem is in an inconsistent state after
  the manual successful manual mount? Do you have any error/warn logs?
  What tells you that the filesysem is inconsistent?

> 
> The below system log, with redaction for unrelated messages, is taken
> from a boot sequence for which mounting has failed, with kernel version
> 6.3.0.
> 
> Note that attachment of device `sdc` follows the mount attempt, as well
> as the announcement of scan completion.
> 
> ---
> 
> kernel: Linux version 6.3.0-060300-generic (kernel@sita) (x86_64-linux-gnu-gcc-12 (Ubuntu 12.2.0-9ubuntu1) 12.2.0, GNU ld (GNU Binutils for Ubuntu) 2.39) #202304232030 SMP PREEMPT_DYNAMIC Sun Apr 23 20:37:49 UTC 2023
> 
> systemd[1]: Starting Login to default iSCSI targets...
> 
> systemd[1]: Starting iSCSI initiator daemon (iscsid)...
> iscsid[749]: iSCSI logger with pid=754 started!
> systemd[1]: iscsid.service: Failed to parse PID from file /run/iscsid.pid: Invalid argument
> iscsid[754]: iSCSI daemon with pid=755 started!
> systemd[1]: Started iSCSI initiator daemon (iscsid).
> 
> kernel: Loading iSCSI transport class v2.0-870.
> 
> kernel: iscsi: registered transport (tcp)
> kernel: scsi host4: iSCSI Initiator over TCP/IP
> 
> kernel: scsi 4:0:0:6: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5


> kernel: sd 4:0:0:6: [sdc] 2097152000 512-byte logical blocks: (1.07 TB/1000 GiB)
> kernel: sd 4:0:0:6: [sdc] Write Protect is off
> kernel: sd 4:0:0:6: [sdc] Mode Sense: 43 00 10 08
> kernel: sd 4:0:0:6: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
> kernel: sd 4:0:0:6: [sdc] Preferred minimum I/O size 512 bytes
> kernel: sd 4:0:0:6: [sdc] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> kernel: sd 4:0:0:6: Attached scsi generic sg4 type 0
> kernel: scsi 4:0:0:7: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5
> kernel: sd 4:0:0:7: Attached scsi generic sg5 type 0
> kernel: sd 4:0:0:7: [sdd] 2097152000 512-byte logical blocks: (1.07 TB/1000 GiB)
> kernel: scsi 4:0:0:3: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5
> kernel: sd 4:0:0:7: [sdd] Write Protect is off
> kernel: sd 4:0:0:7: [sdd] Mode Sense: 43 00 10 08
> kernel: sd 4:0:0:7: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
> kernel: sd 4:0:0:7: [sdd] Preferred minimum I/O size 512 bytes
> kernel: sd 4:0:0:7: [sdd] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> kernel: sd 4:0:0:3: [sde] 524288000 512-byte logical blocks: (268 GB/250 GiB)
> kernel: sd 4:0:0:3: [sde] Write Protect is off
> kernel: sd 4:0:0:3: [sde] Mode Sense: 43 00 10 08
> kernel: sd 4:0:0:3: Attached scsi generic sg6 type 0
> kernel: sd 4:0:0:3: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
> kernel: scsi 4:0:0:4: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5
> kernel: sd 4:0:0:3: [sde] Preferred minimum I/O size 512 bytes
> kernel: sd 4:0:0:3: [sde] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> kernel: sd 4:0:0:4: [sdf] 524288000 512-byte logical blocks: (268 GB/250 GiB)
> kernel: sd 4:0:0:4: [sdf] Write Protect is off
> kernel: sd 4:0:0:4: [sdf] Mode Sense: 43 00 10 08
> kernel: sd 4:0:0:4: [sdf] Write cache: enabled, read cache: enabled, supports DPO and FUA
> kernel: sd 4:0:0:4: [sdf] Preferred minimum I/O size 512 bytes
> kernel: sd 4:0:0:4: [sdf] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> kernel: sd 4:0:0:7: [sdd] Attached SCSI disk
> kernel: sd 4:0:0:3: [sde] Attached SCSI disk
> kernel: sd 4:0:0:4: [sdf] Attached SCSI disk
> kernel: sd 4:0:0:4: Attached scsi generic sg7 type 0
> kernel: scsi 4:0:0:2: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5
> kernel: sd 4:0:0:2: Attached scsi generic sg8 type 0
> kernel: sd 4:0:0:2: [sdg] 524288000 512-byte logical blocks: (268 GB/250 GiB)
> kernel: sd 4:0:0:2: [sdg] Write Protect is off
> kernel: sd 4:0:0:2: [sdg] Mode Sense: 43 00 10 08
> kernel: sd 4:0:0:2: [sdg] Write cache: enabled, read cache: enabled, supports DPO and FUA
> kernel: sd 4:0:0:2: [sdg] Preferred minimum I/O size 512 bytes
> kernel: sd 4:0:0:2: [sdg] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> kernel: scsi 4:0:0:1: Direct-Access     SYNOLOGY iSCSI Storage    4.0  PQ: 0 ANSI: 5
> kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 11 transid 309446 /dev/sdd scanned by systemd-udevd (371)
> kernel: sd 4:0:0:1: Attached scsi generic sg9 type 0
> kernel: sd 4:0:0:1: [sdh] 524288000 512-byte logical blocks: (268 GB/250 GiB)
> kernel: sd 4:0:0:1: [sdh] Write Protect is off
> kernel: sd 4:0:0:1: [sdh] Mode Sense: 43 00 10 08
> kernel: sd 4:0:0:1: [sdh] Write cache: enabled, read cache: enabled, supports DPO and FUA
> kernel: sd 4:0:0:1: [sdh] Preferred minimum I/O size 512 bytes
> kernel: sd 4:0:0:1: [sdh] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> iscsiadm[721]: Logging in to [iface: default, target: iqn.2000-01.com.synology:diskstation.default-target.b890048b949, portal: 10.4.1.2,3260]
> iscsiadm[721]: Login to [iface: default, target: iqn.2000-01.com.synology:diskstation.default-target.b890048b949, portal: 10.4.1.2,3260] successful.
> kernel: sd 4:0:0:2: [sdg] Attached SCSI disk
> kernel: sd 4:0:0:1: [sdh] Attached SCSI disk
> 
> systemd[1]: Finished Login to default iSCSI targets.
> systemd[1]: Reached target Preparation for Remote File Systems.
> systemd[1]: Mounting SAN Storage...
> systemd[1]: Finished Availability of block devices.


6 devices sd[c-h] got discovered at this stage.


> kernel: BTRFS info (device sdd): using crc32c (crc32c-intel) checksum algorithm
> kernel: BTRFS info (device sdd): turning on async discard
> kernel: BTRFS info (device sdd): disk space caching is enabled
> kernel: BTRFS error (device sdd): devid 8 uuid 3d66ced8-24c1-45dc-9d70-8a921764dc88 is missing

Devid 8! How many devices do we have to this fsid?
As before do you have the dump-super?

Do you have -o degraded in the mount option?

Before (what ever is) calling the mount has it run
  btrfs device scan  ?

No I think because I don't see any device scanned messages.

> kernel: BTRFS error (device sdd): failed to read the system array: -2 > kernel: BTRFS error: device /dev/sdf belongs to fsid 
c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already mounted

So what is the time diff between above two messages?
Already mounted => might be due to a race condition?

> nm-dispatcher[919]: /etc/network/if-up.d/resolved: 12: mystatedir: not found
> kernel: BTRFS error (device sdd): open_ctree failed
> mount[921]: mount: /srv/store: wrong fs type, bad option, bad superblock on /dev/sdd, missing codepage or helper program, or other error.

> kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 8 transid 309446 /dev/sde scanned by systemd-udevd (376)
> kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 6 transid 309446 /dev/sdg scanned by systemd-udevd (365)
> kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 7 transid 309446 /dev/sdh scanned by systemd-udevd (363)

Scanned messages appearing after the an attempt to mount so for sure 
mount shall fail.

> systemd[1]: srv-store.mount: Mount process exited, code=exited, status=32/n/a
> 
> systemd[1]: srv-store.mount: Failed with result 'exit-code'.
> systemd[1]: Failed to mount SAN Storage.
> systemd[1]: Dependency failed for Remote File Systems.
> systemd[1]: remote-fs.target: Job remote-fs.target/start failed with result 'dependency'.
> 
> kernel: sd 4:0:0:6: [sdc] Attached SCSI disk
> kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 12 transid 309446 /dev/sdc scanned by systemd-udevd (372)

