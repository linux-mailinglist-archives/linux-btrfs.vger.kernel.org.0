Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269C36E5D49
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjDRJZx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Apr 2023 05:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjDRJZv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Apr 2023 05:25:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1856B55B9
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Apr 2023 02:25:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HLTefl007433;
        Tue, 18 Apr 2023 09:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=d4njQZ2/B7xRFEA4ldd3elC5fUH09nW9iDU8w6TNVO0=;
 b=BR5LKrF2hvcguKz75Sv//XRdMW85V84XExo91m+PWO2YZ7bls6DXVvZ4Exr4m8Z8z9Gz
 vuMzeY4LRF7kIG6rJ3+jSjU4oCiztLAqWcEth5iM6ULkWKJgsuKxGW7h0EiFzMLkq5Oq
 KsKxjx3EJS7U8u9n8pMzI9dDPpxB8GrZifO82iFytCCHaSmY0VfM6al0/8K5MPrbdBgh
 uLKDQGzMsCoDHjPdBIqHbtRgi94QK0y65eYo8yQm+XCGvalIXvnBZMkl38f/WkODuxhm
 1jh2Rv68lgbtxn69T//DYgpDqOu8veV5yS2lYW3yUdh7jGmF6x4bS21xsjAUF/Vwa9l4 FA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pymfud63r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 09:25:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33I9NhdA029854;
        Tue, 18 Apr 2023 09:25:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc4sa7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 09:25:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eroKWwGZs9vIdZplJP9It9GM1VZhldKpk7HQ6lX2uv4/vglbf8Jg20bTjjETmvXIY3TGGjXAf9M+DasB8ap3r1RGyjaCPd/pBRMbVuts56fCMld41oYNNzLfV/4oeopvIQ73jemtNL6WwUxEdRZ2G1pHW9SW+jbVHdD/WxKyzJnDbpJTjpVwq4fG0idmUQogpyDT3XwBwRyYgVCoyY2XPl6owgK4qg24spsYE3CGGzy8e1EbfY1LO7xxx5noZTjMqA+b6FaGd2CpIH+WWgy3V7xb7NogFEN1lo8VY0CJkEarpmO/JsD66NGM02WpNe6ZYoRqKwJ7/f0xh4zo985d5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4njQZ2/B7xRFEA4ldd3elC5fUH09nW9iDU8w6TNVO0=;
 b=ZrEDSJF+nLCIUOpFLr9DcLs5dB7aAByn5Ky/eMqjzlg8Wj9LjBKWkmTS+PaK8xPrVWet+MRp409wUbxvr0eTWBsQCJYRwC9EGpu1jrsf/Xhyz+FZvK8SbmIBUCPVZHSU8keCoCJVZlH9I9JEh2hpLoG3IPR5ibcDOCEy35LCJhnnsLrXonEsR1hqW2PBgNWzxh/WHW0vxzMXeOzpqbNJTndhdsXLhyWu07hPExjkHXEDWfgXI/Q3C6OAs+SMLiTei4o+SQC0zpl9LXpjeApH2v4Q/tHxwrWm1QirZ7bDX0U59FKYL1gOh8DdyySa3oP1fcdQSTLsbAYOoa/oRK0Tgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4njQZ2/B7xRFEA4ldd3elC5fUH09nW9iDU8w6TNVO0=;
 b=fJQI1B5/zqV/1lybRa/GEvRtv4sD7ssDgd2vMapaIUzce8r1vHrEQuJJV60n74ZyGbcNcB0nAJlIZl1NI5MX6FQDrv1zVicXKPapazqJo0KxL3+KixF8DrkgrVToD3yqfjH+wJ5Hx/sfKKBqt64/OnK2FqOLH6+aa5jC6uzviUM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 09:25:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 09:25:36 +0000
Message-ID: <30a3f762-5bad-da85-738b-dde8f41b8171@oracle.com>
Date:   Tue, 18 Apr 2023 17:25:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs: output affected files when relocation failed
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <aa446804b679949a1bd77e653a205408af43048e.1681780522.git.wqu@suse.com>
 <9bb5f4ea-717b-2365-652a-01b130452118@oracle.com>
 <6fc3db31-cb9f-de32-cd4d-1d9d63270ba7@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6fc3db31-cb9f-de32-cd4d-1d9d63270ba7@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5e4e85-1669-421f-ff92-08db3feede1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TrDNWDTcBu9x4HP+TXWUbRAQ9Z76mnwZAWtLImHyvQfu/KqiChqM1GREuYslTj4gQKY8ZQsxFWu88aL9OvevSN0s5Ru61vRXyo+7nb4eANGJ5ubplBdRO9NyC19jrAbB+to82r+tudYI6HTNwmxyW2yl088b/9eRsief36Vi8AsE5MnTfmuWaqL1IGB8C+Ig8ugQEs2qdmG0LjzRxH5Q7tYj48gj2gwys0ZH5+l951r5l6/7zWCAknjzmWJYDumnJouJ3opaOfMcf/SERyvDO6ZAf9PxSUZP976b0RIsNlD7ZqiYB2jD6NrdFR7NStqulBQKyjAYJHmZPzRxqwcuR4OLNJq4go/CznNsA48R1d5ZvvIjrRz+A6RTnvZ4pcxn1H088SKt4nGFeLILnIqOhDvHuJF5OjQnPT6sZWF5MTQsYoyEkzcgzf+IiJGzCObw8dFWJA7alT9Qjl83xe1oPb9v9h5kpuI3lU9ii7VpBc++JPHd0fGnFkOAFfHjWav/AeeoqQnkWzc4pmLvUdp7xlJtWinxe+ontH44o4YKkjvhf2ICm6kk3WCoBKYVF7+P9I1zCPY+R2aR5h1ju+QXW7UYviU1wczaopMwIdcYsns/81lFn7NcOZi5oBr+Tc483bWY1+AK3q6VxoJyZrEqmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(36756003)(38100700002)(8936002)(8676002)(44832011)(5660300002)(2906002)(4744005)(86362001)(31696002)(478600001)(6486002)(6666004)(110136005)(31686004)(186003)(2616005)(6512007)(66946007)(6506007)(66476007)(41300700001)(316002)(83380400001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1RjdnF2cjgyazdYS2UxejlDdnRNYnhMZHA3Wm1rK0M0cURsVjhNZERhL01C?=
 =?utf-8?B?T013dDNSbWE0dGI2eElzRklBOHJ2b0VTL1pjUE5mNE5ZTTNLS1U2SlV3cWJl?=
 =?utf-8?B?OGRQNWlyeWs2ZnRwSmRIM1hackFVMHUyMDVzOWxhNEVXQTN0ZGN4NGlVNEpm?=
 =?utf-8?B?UHhYRUg2bWZzVkRlMWVyR0pxRHczVHFtbE9YU0lsQUhGTERSdVVzYXFFYnl2?=
 =?utf-8?B?Mm40NDh6KzArSWVHOFlGTm5ybUU3L25LZ05NSDJ4YzJUU085VlBXSjNkWjQx?=
 =?utf-8?B?Ny9qWURNZ3lTeW1KMC9CN1NaRlR5dis0dTl1VVVCOVFFT3F5WUQrVGN3WWNu?=
 =?utf-8?B?NElYSUZ4QzUxSktiNUx4Rkl6QkV4TENsTG85bVcvUDhTVktBMndXbEdLVHQy?=
 =?utf-8?B?Q0J0NUN2anFOOUpJZVVKdmQxNkNKWUozNnRUVkVQRXVUaE8xNWkzWlZjek9x?=
 =?utf-8?B?VEN0bHZpWVdBNHFzY29wWHFDQnEyKzVNLzNrTnJhMVJvV1dUbVlqVExLRktv?=
 =?utf-8?B?amdtcTI3WEd0bzJJY2hjc3p3bXkwd0pqcDZOUG4yUm5rTkpQR0VxT29DVElm?=
 =?utf-8?B?K0pCaU9LMWJRL0hLb2V5am00WDUrYXBGOCthc091R09lRnBTcWFGZ09idEp4?=
 =?utf-8?B?UysrcW1DMWEvNDgzNjMyUTJUc3JPbnFVYm1DZjdNTVJHSk9WTy9sQXBVN0tL?=
 =?utf-8?B?RmJEclpzeUk3YVoxTTVRM0FCSnFTUXdDU3BObnFtTlJndWtLeGVMS1N4YlFU?=
 =?utf-8?B?YnpycVllTVZ1RVJ3QmhXUU1GNnl2aW1xWEZhdDNVbGl3TjlmTWRPNFRiTzlx?=
 =?utf-8?B?L0xxVjd3Wlk2SDZPcmNqczNzeFBSdmJrR25HOUk1eHFVMzhucjJISWFFbm9r?=
 =?utf-8?B?QlJGV1EzbFhpVUJOTWd4U2dhZlpyR2lqWFdRZWlpWUxvSmlHS1FTQXNJMnNB?=
 =?utf-8?B?aW5uQk5uN3NNaWNKT056VytiVnI3OWFZQWVsSDc0eEF4MVo1TnhVYllMc0pG?=
 =?utf-8?B?NG1Obk9QRzVrK2duM0V4TWx3ckd2V1ZtQmU5ZVYvYTNlYlR6dVpoaXZSMVVl?=
 =?utf-8?B?YU0raHNXbXcxbHFZVTJnVU9lSXVKNFFhakxtKy9PM242SEk3ZkZzU0cwMnVh?=
 =?utf-8?B?TXhuelBBMllWb1ZyNmJVS3VsYitFTlhVejc3YUp0N1RYS29aaUZsZEhXRXF3?=
 =?utf-8?B?RUpaRjZ3WTcrTW9TTGNBajlmYmR0UmhoOGFuVTM1VWdqMmc1VzM2dW9BZjA2?=
 =?utf-8?B?OVJyem9jNHM4ZE9JY2I2YlhXMTdNaEhlUy9JU0NUcU1EUUhBNUFGL0laQW5a?=
 =?utf-8?B?QWIyMjJaYlJzTnlIc2IwcUYwem1UT2Y3VW9zdDBSVlEvaXliVjloeGFpbUNH?=
 =?utf-8?B?eFRmUzVLUFhyaGFXWmQ4YkVmUmw1MjVmd2NUZnNISHI5eG1rYWtPM1BBQjJI?=
 =?utf-8?B?UG1ZeEp1N0xYQXp6UkUyZlloOU1PZ2htM0NsWTFldStYM2ZaMzJVWFFxMVU4?=
 =?utf-8?B?dHBRQ2k5SllYMEV6eGRjWDFvTmkySXk1T3NhMTAybVJaTHUxY2w1dTQ2UVZB?=
 =?utf-8?B?N1NJWDU4eHhrQjJpQ1FVbjBXUkoxZDNyL0NSMWRPNEZQbHNTemZkZ0pUOGp4?=
 =?utf-8?B?b2tmYXNuV2ZhMzZqWkpMZ25mZ3FvdTRWVHk3elZONlRQSy9jVkFJaHlQb3pD?=
 =?utf-8?B?eCs3SDNVVDdoU0hhT3NySFVMNmc2TnY0OHJmSHpSTm1sVVlaTytLbi9FK01H?=
 =?utf-8?B?eXZ6dUY0cDV6VGptL1ZaRFJYeUphamhwaHY3VGl6UjNEZEtYeXVTS2lQL3dj?=
 =?utf-8?B?RU1VaDh0bEsxcks2bExoQVdTUkg5OGZ6eWtyQTh4MmlGSGxMQ1pnLzFMcEty?=
 =?utf-8?B?elhkaklFTmlYUm55K2wzYU1PS0FmSElwWmNjallpYVVUOGpBWURlaDNTUmtD?=
 =?utf-8?B?Y2IrbEtnbjdwVFZTK21QTzUvMmlUd1hZQXI2QVhKUW9QNnNweWRRRjJMeGpz?=
 =?utf-8?B?VUt0NDJJb2ZhUFRreHBESXNPejZDRUNWV2c0RGZlc29BdTFHMzZxTUVDRytx?=
 =?utf-8?B?Mk1LS3Fub2h6bDZpYzE4ZFg3Nk5SRzlkTzNteEJ5MnlySVdUcEdsa1lyV0xN?=
 =?utf-8?B?cENqZ2tSeHhyam5nT1dMa0tQN2tvRm11N1N1YlMxR2RQYVhyN2JmdGpZTlZ6?=
 =?utf-8?Q?JmoeRss4wpGoRfmMTGeEsrxf0JIChlrAyepU3fYp8oHn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oaVfOMlghcPMf7nidO5h0DFkGObscDh7J5vK7LKPuzgaB1wGef3bkxpcvcj96RCylKbO9j1FF3R2AI7xm9ahr/esmVVycV1rFosg+8kVAR7GrtN7lcHJ8SoyOWpf7YDpfFHV0lDvFP7WAITrgZUkYrgdrQKRrYzF0zIcOUVcwkB2kL7SLmBxdTMQrF8xpb9Job8z8NUA/smphw/vGmMWHCAEjvxLgddKxUDPPjboWjYVD+gjKmzICC6p1iOewQ54dceFuw6y8Mjs86tS2LTTOp++FS1sP7PxVEkRBfVzptdVF3DBUPkVaCjE6fmiKZtBkn3jszCLnSLEZJVGSaVM1LbWvSDCpOPHQ+PTq/75i2Sv+1emqSzYlH58DfatmyBMGN4li0t7TiyI3nVCv1TqkGQGiJ2aHDmPCIBAqWvxmwiCoI88guFAVX+CrTS7eFTpcvZzi4nlKhRwOoIFSSmlIySrIHkUDWzn2m4mQxKK/6//4Mc49gHWqRzMbkHV2EXjgOZfW6CChimTtMyy26+kZwknhXju4JFXt2gBq7xGBgACM31URy0nAir4aE/LmYcJa+fo1otlzDCzKMurWE5hkcBxdy3PsbFUiRM/JxqBCEaMugVKJ28KHBhQ7kedFULP3UhDC5G3vS+3SHY6oGol0sPQiwkjNEy75xVg1piNSVDXqQQ/I0+2VI6pk1xQcdwAnD1W7tr+pucaUDyqw/jYEUM0+ItWv0/XfUSOwWcbAbkdnTFwz6XqVRLTS51Rw66meWYcO/tlBn2iRZ62eh+itaempMb6Ii4F8N4PtmODxlTDfzYzm0gVYOOt5w1pVQIe
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5e4e85-1669-421f-ff92-08db3feede1f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 09:25:36.8961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmSmTKolJMZ3vlpieHLhHP9pvgULWg+15bnNWElLLctlWDfI7S12/nunAmIbgAWwUEE2kPpovdkn74fPskF8/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_05,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=913 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180081
X-Proofpoint-GUID: MAcyUt71rysRMSorxt3rOXZe-QLp_wJP
X-Proofpoint-ORIG-GUID: MAcyUt71rysRMSorxt3rOXZe-QLp_wJP
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



>>>    BTRFS warning (device dm-4): csum failed root -9 ino 257 off 0 
>>> csum 0x373e1ae3 expected csum 0x98757625 mirror 1

>> However, a nit as below.
>>
>>> +        btrfs_warn_rl(fs_info,
>>> +"csum failed root %lld ino %lld off %llu csum " CSUM_FMT " expected 
>>> csum " CSUM_FMT " mirror %d",
>>                                  ^ %llu
> 
> Nope, that's intentional.
> 
> Try to put -9 into that %llu output, and see which is easier to read, -9 
> or 18446744073709551607.

  Do you mean btrfs_ino(inode) can be -9?


> Thanks,
> Qu
>>> +            inode->root->root_key.objectid, btrfs_ino(inode), file_off,

>>> +    btrfs_warn_rl(fs_info,
>>> +"csum failed root %lld ino %llu off %llu logical %llu csum " 
>>> CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
>>> +            inode->root->root_key.objectid,
>>> +            btrfs_ino(inode), file_off, logical,
>>> +            CSUM_FMT_VALUE(csum_size, csum),
>>> +            CSUM_FMT_VALUE(csum_size, csum_expected),
>>> +            mirror_num);
