Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312A669F5AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 14:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjBVNec (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 08:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjBVNea (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 08:34:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9D23B23B
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 05:34:12 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8x0Sn001203;
        Wed, 22 Feb 2023 13:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xqjoQkZ2vuh8MqLOsud7CaZN6OwSdY3L1xdG68LqR4c=;
 b=WUNieadYxSy35rQVv0YrgRBZw71SSIcXy4wgd7UzFJBy/B7WNrnwvZk/oOBlbk74TR13
 pupH/Ij65c42tyS9JxpMbRB+tntMatJDg5ro+X2Bo0t0fCyCw3WRX/LtX08mrReC8fv6
 7M2w6b2bcnl14B5lDJcTyiHbs53C6/s4OI9pKOXapIB02E/Jkg305ER3EduMadbyP1Es
 iG1d8X7rGIJPkvxViFOLVSNsGOr/VBA/bFZd90W6c0oTZvu274pYozeWZnwMvfHlTpzb
 QxFpbZbW8x875Gvqqiohle8JFJhYsJscvpsftDeVtj9OekVlX7BIS5LUTL9kBhhTBbr8 Bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqcfvyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 13:33:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MBn2RT006683;
        Wed, 22 Feb 2023 13:33:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4d4gjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 13:33:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw2FwR9sXnpt66uu0g0Hc6fBfJ4arAuDGzs3261geSuJwhhc2h6MuU4afTk9N+spmYuiah5whIaa1KdaVEsAmFtyUdSRgwWB84r1AzFuwmM/uRk84AzmdZKl0Bucgj+HRahrBwA7JH4yAz0CvBV+eqLfLigqp9dF66zlm64ngCPfjDh4iPxjvjycYNqC/fHiX1GMGAuHQgeHr5ciehWynAuB9TD4Q8d1lK/Z8VmQqBV8hKyxtTIV/nUSnxJ+rGSorC8ac521X/5MG9xrj5zVwn5VlZWHzdChtAu7QmNOGByQfTVQcRyTkPo86YKdLGhOyj8ade9vuOZREMguBtUZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqjoQkZ2vuh8MqLOsud7CaZN6OwSdY3L1xdG68LqR4c=;
 b=jMPvYE+lUpk6xFOyMcd/ocOwBs9+Fi5omX/VYitfot+ojsNjTNIGyZVRB4Fv9UwvqLlgWBGIOju702dCpPNmb8IbyfFH982rUnFeVMCpEPILaAqsrIIqOfCd8mKzrsSzXE3mFUacHQHiLvDKNK++7s1gKIOTZAJywhauSrZP+9uwKVwZgamYg7SmCpNQN2gBqwah8o8PvcIRs5sHg3bkgJ6AWAtH0y9Akeb7mSUsWeb0v5nm0DZkHPEU3oQezTV3XZ++kSzk2FQDal3/SF5bMYK8EksyOujphAdhpWMeVbBQdcZdonW+Oj2lxgU3fs3Qvo64Bune5op9M0pgIDdFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqjoQkZ2vuh8MqLOsud7CaZN6OwSdY3L1xdG68LqR4c=;
 b=KZjowXXObBoWDOTfGXzk+lxoUqNtNIvS8SzzdUAisBV91G7+y9LXeAIL9LedapnRl5I+0cOJWFf7rdkisA1W7I21JnaCBKRESRN8Af/X6sz6/gOTSjA2k8A/HHU3hHx5TLxQxlnCD87+ciAP3oLqBSh/QlRIypG6YdpFZCHVW8U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB7079.namprd10.prod.outlook.com (2603:10b6:510:28a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 13:33:33 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6134.015; Wed, 22 Feb 2023
 13:33:33 +0000
Message-ID: <7599d3b6-0789-7885-3b4d-f0155f9b6d4e@oracle.com>
Date:   Wed, 22 Feb 2023 21:33:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] btrfs: remove search_file_offset_in_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
References: <20230221205659.530284-1-hch@lst.de>
 <20230221205659.530284-2-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230221205659.530284-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e06138-06fc-4c88-5a34-08db14d96454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gib130/C7zPHuaNS+vqbN05MpMd3QL2zygwAVSNODcUjywmsMPDmcTjs8Rqzx/r9lx0rdXqInIXuuEjgfXYPNdkmzZKqjBrJiU7ylHwabshWsByHeLRdaMpNqWK+82cST7S7O/fLqBSaq7D04BjMByV0ocAC5wK4y9bvxxzM8Ya9tezrAypngcAWMyxb9SgdXeM+Ex6DBSgBdkRNiiaORw84v2Ft1oZ6iD74Ah/tEo+KuFRcNTV91/Md5Rue7c+VhXOv+zZb8Ocve9eJEHEwhRmwS2vsi38jvDKUYO4I/HT6k6x6xeb853yjle6b3kAUgfBcdv1Oy9QtFWYot6miC4yy8oES1YxXmRNJOwXy2uVIETIpfECzwFuFzREftmJFNNCZp/8FCybJtj3ckYNn3qfqg6e/2iemN+BlBfTiEoIEhUHCS+zp3xtJzlLFtNIjapdrq/BAA3wG9BYQ6kHhCeMc7CcYocZJKg/5QFwPXI35EaSjYepDynTrHzYXG9Pzh+aafkLPYE0nB5RnijWKecyikjWnaMQvPvqS357A29oUkuabZaFBwsictlVjA2byzDueY7+7dXORIIEDfLbiUUImZlEOR4DJaAxgzAl7BoWKmMvomxS+K/nORSF8LfKj7T2R4y+jxicgwY1ncnmlfF3P423PJulBwL+lOAurZ5t2BSaeB/JndBP+rrZfsn6ZxXB9fq7bH/vfJSqp0LYpwmSq/CnNsp/DdMjfBRBuino=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199018)(558084003)(31696002)(86362001)(36756003)(316002)(54906003)(478600001)(6512007)(6506007)(6666004)(186003)(26005)(4270600006)(31686004)(2616005)(6486002)(5660300002)(2906002)(44832011)(19618925003)(38100700002)(41300700001)(66476007)(8936002)(66556008)(4326008)(6916009)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzRjTUNheVp0SURNZWtQQzF4bmMzd2laa0I1SlZJditaNVFIamMraDhMOXNx?=
 =?utf-8?B?eFRVbFdUNHphdlQzVzVRZ0gvNktCSldUdnV0N3U0aEVnSmVYdWE1d3RQb3dW?=
 =?utf-8?B?U0ZMcnpqZVkrTkdvR1RIckY4VGVwekVwTTNnYWthbXdwbmVVV1VZakJ2M2lU?=
 =?utf-8?B?L1U3UFdHQ3BnZDA5ZmEvakg3WGJyMzYxQi93VFNHOWNDY0luQzA4NnozQURx?=
 =?utf-8?B?Uy9YNTBGcFd3UXZXb1BBc0JON3NRQmwyTWduZVdsekNuM3I5dmJOMlpSY1lq?=
 =?utf-8?B?RzlYYit1YVVKa1htMVVWcmZ3cjJQdXhSS2FHeWVXUHJTQVhGU2tYcDZMUStv?=
 =?utf-8?B?VjlmRHFNNjFsMGk0OW4zaXpQNk5DaFE2SElvOUNuUGNrTjZacE1lQUZPclF5?=
 =?utf-8?B?Nm5hM2Z6b0w2QjhVMzA0UlUzVitlRGhndlJ1RTVCeDVrUS9zYWMrL0NaYnNt?=
 =?utf-8?B?WkVlU1NoTWxTMjNtUXN3NlBZQ2w1c0QvcHBIRDdVbkQ1a1hJM0EzdU5JMUdI?=
 =?utf-8?B?ZkxEa1kyRHBLY2ptM1crMXhxOE9VMU5WMXI4ZHNySS9UWW9NQVN4WE9ZY3dX?=
 =?utf-8?B?RUZsazA3a0tCbW5kYVpnSzM5Uy9Zc0doczlMWWpoMGNhdTBBelpWR2x6RWla?=
 =?utf-8?B?RHVUL25XZHVZUzUyNmE4R2c5Y0NNRit5VXZTOUx4RVdrUlJzWWFFY2d5Wk1O?=
 =?utf-8?B?OTh4Ly9XWGlOeVJmejNnanc2bTNucGhRQVNENWxmRERPbmV2dHo4cFduR0xm?=
 =?utf-8?B?VDRkQ0V3d1ZlQWZVRVVibDNqTW5FN3A2dGpGaFM5RTBFTEN2MUVoZDhRR2tU?=
 =?utf-8?B?bjA3eC83UTFqYlVBR01Bajg2SDRnclBkVmdTbUpEVUtxTXJpbncxc3NvdXZZ?=
 =?utf-8?B?SitFc2Q5YXBXcWRsSk4rcm1hNVFBS2Z3cVYreHNkTXMxdHZZVDFSV3MzZFBt?=
 =?utf-8?B?enpkSElkTWsvNGNSNjR6ZkpZRkU4ODJHZXhZZUZyaG5uNnBYT3dPRXNKemlK?=
 =?utf-8?B?bWtHYW90ZkNLSHhLNVB1SG9BT253c2pYSmZpSVBnbnhMam1rTlRjYzFYNEtW?=
 =?utf-8?B?aytWZy9Bb3VuUFlyMkRHL3ZpMElmOGJONU9TNDZ6VkxXcHEzQjc1dzRzZ01s?=
 =?utf-8?B?UlMxNGtjeTNGL3BzaHd5cUw2VStuRFJZSmhhRUttTWRBd1FIRUNzVm5IelN4?=
 =?utf-8?B?aWlrOFIrOWd6b1FGWWRnckNWOFBUaVlsVXdTQTF3VlY5L3ptVjdKVHZuYnBO?=
 =?utf-8?B?YitNVVdWVUcyL2FRVlFuSTdWNjJYZEFYNjlHL0tEL1F4bm56VytJeGtscHNJ?=
 =?utf-8?B?NFRwM09vNWhkRXZLUjlhMDV3dWQ4QlRNVXY4cURkQlZ3U3hHVXhyYlpxRHNW?=
 =?utf-8?B?NVNQSTZyK1QrMUdFRnVwWTU3c1NrTVFTK3NSSkRyL0p0eEo3VFhDN0pZUnN1?=
 =?utf-8?B?QWFsekhYVGZWWVlIb1JZd2J3TTFEVE1ma3dtK2pjTjNocjMwbW45eTVPbXRv?=
 =?utf-8?B?akxNUTlLN2JUK0F3bmVUcitPbHRYSlF1MitpNnJ6d1lkWURvSkVtNnJsNTYx?=
 =?utf-8?B?NVRpSWdXRmtoNTdwRUl0b0FWVTZCa1ZTTVlkUHgxck1xa2hnYjNxUkNDMzF2?=
 =?utf-8?B?TFZkZzJCODJhVWZBMllkTXhWdExTV1pweENkcG4yRlF5ZWRRL2p0Q3BXZHRp?=
 =?utf-8?B?VEQyV3B2aG1ua1JycVIzMEQ2NnJYSVRYbG1VVXc0ckRDU2RaTlhEWGxqejgy?=
 =?utf-8?B?cnU4SE8zRzFjeXJxWDhKUUFoNVFBbUdpSmNDVlU5clRZR3l2NHRndXFxd3dE?=
 =?utf-8?B?R2c5VmFOcTlIVnlyU2s0emovbDdsZHV4MzVlMDZKY3RoNTVzdVlMdE9IY3lU?=
 =?utf-8?B?NkZPRjYrVXQ1OU50V09oQlF5UlU2QmxWR2h0NEdRU0VaSjluWm9yM2FlR2N0?=
 =?utf-8?B?M25vM2JNK2U1SDdrcTBaQm1LR2R5WVhVNHRoUlk4ZnhlS1pLQ0RQQm9VVjdC?=
 =?utf-8?B?MCtDRzBSdm1GY1RJN0JMQ3FxemhiVTFEZDF5T01mNTV4R2thTnp5UjhmYkJj?=
 =?utf-8?B?QTE4Q0J3Mlp4c050ZTAreURJM2NWMmJhTlRZM1Jod01IUHhmVnIwVDM1Um5r?=
 =?utf-8?Q?G2RD0Yor5DoXbiX7vFVTPDdoV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6CCn6GHf9b5a/ySOh3/w7UcZeN8G8PrttfJAjSwC9+QxIM8IrDtAVzH3CMulBuVZxfos7vFyrQTVT/I5arKJt7c/rWrTxKUfwRMFmH3xH8kyoGqC4iNyg9VUVzLIw1bEYzaINI+SIy2nxzc6PcDxttYGnPwkG3gOuG6pnPWBYIzt90JDFVW55U4GpYZo5Mk8nET8WEZvLSIT9DUlVEe56HnRU3EZPxImbLC57ZGpSPrSMNu0lNRfnn+Gc5ow8LE6vDbECiyB9ai7YEXk2Xa7TtTw8EUeSkW8qet1nY05IM3bk+N9zY9luB1XpVUUQuKYrOM/XRFz/XrxiOW9oYT8Q0SYKCswUNpahDFhmGC/k+So77bZm7xboUlSEnQNJ10LDWylZDp30gZD5cgutVQQGWFyZg1FYBZOOkaBOMzKx6bP3qydhFYHo3JmjMYwfsLexDAzC6y6fjvcCxkYfYprUclBaa+k+MOMmY7PMog4U7R0Nspr6JBZ4WQZQsJ4/2zlmcioQOTarr6srR3Q+n44y9jGUNn73eRmEKwZq/AbG7A7pvfqXsanZSA4DV/E755ExdRHHgRZv6/IevYPcJRAj05w57fQ+kXWTkkX/6AW+EpLxWKR1TjzBoh2g1udjoq6ziuFLy6wOJCHnNIBCyS2aPVJzDy+fZcbRpMCwhWOU2yXZ17OCufupct6b23YMeMSrjeRr++ZT0Mq4cHA8R93L7n6zD2JDwYr0YvlVEKCpMox1HppjvGTJI4sUiwNSQ/hkkkWWaMdbru2e3I6L8v3gyXrVzlIeRvkMmnz7yK9cU2okjdAWap5uPNncL7AL7Hp/MKLg0hT6c183p4AwTBnsb8CHSZt21Ws+6BE5PYngxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e06138-06fc-4c88-5a34-08db14d96454
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 13:33:33.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHtWtVUDorsVwCkvlH7Xonz3v4mPveotwAylp95LG0m/QvrvZdDJ1RwzvmQEWeMesb7UPYaMFFraZuMWduuh9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7079
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302220119
X-Proofpoint-GUID: PHZbQM-M-uWHN4vi6-lH3FKFWFII_IId
X-Proofpoint-ORIG-GUID: PHZbQM-M-uWHN4vi6-lH3FKFWFII_IId
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

