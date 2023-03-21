Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95B26C338A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 15:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCUOAA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 10:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjCUN7w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 09:59:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADDDFF31
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 06:59:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LBiUlw010823;
        Tue, 21 Mar 2023 13:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=MdZT8ogal8YcmDQHPiLGkidiRbR0G0QIiuilBsWkB05QG5iPttZEzvsw6IhiN0c7mJPX
 doV02BeBfdDH+bmV7LXyhgqHnrTJcdl3GSgIrtl+J2qYKiTqy/oyUfnnMbjCEFvvQ+CW
 GJVikmebkND2QCGsOETToDG7YovVz9YVtMerfQXmZa8Rn5ccgMKqR/0NgEe41EUAio+q
 p/RsebGfcI+U8+YmM3F4C2/eGsMeuDFqoQCtBrdwIwsfsYrn1prgLQGymN/kAacQtGbS
 +MhVWNKiIiQRMSaScyyJoBh/h+hIu6OrsXxX95WfSd1OpHoSv2xzh6vrc8jqLmrhGSQw MQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56ax7c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:59:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LDVnLk036875;
        Tue, 21 Mar 2023 13:59:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3peg5ptb2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5tC0fkx0w/vedRqut1gjGoi258lL/lJmk5X1pCUfhiaLnan4ME2Sg/i3U136WlzygUbQQW+JJAIA9GookbDZHSK1vD3HjCpqZ//grPrnGsFSGWyYwSNbjakKvf3N2mOPFZ4klTLdife5EcgkFKs/QFvLsDyLFXVne96TGcp/eTg1gjfASthm5pW15V7YgHOFXUiEnY3djYmxMlvmqrof8L7ZWI24rNqjYlL0QGWJv6qU1tUhpt55RRFkVThtbgJm01eBdPymzAChTETjip4P3IGNfurMhF5R4PgQ+Nwlp+wKU9mjo+FxkwUHZNYqROMss0NUWdGk2iqb0ukY9lKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=T/qCFJg6UhMANLKEpSLShGckaXRbNxdvgZMLR6B8paASprns2g+I14lJFnssFcn0d+Ugy7Twiu6K11OD7H7XrUfWNykP5KW1c6G4YtjxJd44cIoUwfsE+LC0JXhCJF0Mzbz3rV6jV5gBiJT8v6/IrVwSFJDbusWp74OSROxTGHFZ82jfYeh92l2bmdpLDLAAhJmycGKg9aTnVrMrFKI6grb6wgK7Q/iOXDy+ags+y9lnnAySOLVlUI0DA0mToi7eA6KfyeoURnocXhPnKIYDUyeQXf8CsvYi/Lnq161aK5k4isTSkYCuu4b+96B7to4c9WP9CXtuB136FQIEVnTNug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=qJb+e7KIJxZcFyliVoXEaliL4RxGP1ZWMZ+4B+MqyPSB6AIgvRsUCwJufZ7kfEvGnDkMmhWHhP8TQeywSYTqOlu9CpWIOdA+GTIfN2MUfFvWMxrMG6HKViGNBVYZRKiUFnC0CaJ6zOtAPfcl1mk9OB7aFC7fncuRmgrx5QjLXkc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5971.namprd10.prod.outlook.com (2603:10b6:208:3ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 13:59:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 13:59:46 +0000
Message-ID: <3334fd7d-62f9-a6d9-93f1-0b66ff2c52cb@oracle.com>
Date:   Tue, 21 Mar 2023 21:59:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 15/24] btrfs: calculate the right space for a single
 delayed ref when refilling
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <c473b878432c49031d20dd0fa9e62bc855ab698f.1679326433.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c473b878432c49031d20dd0fa9e62bc855ab698f.1679326433.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d367785-0094-4063-c545-08db2a14873e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wldFOyhf2RTZa7SIQGONL+GPPGjZGFvJtsFnOeUf6oSWqtZ694nTCPKCUoF7fcvVkD/sBO7ykBBlA24H0E65Tgky1fztlP41lN6oSCJ9JDba7rj27qhKgEzjhC35jY7krBy39pJCql/8auPeUuwvpTcXxnEQpWZBJMQkmJgp5POxpZoSjMFquJY9ADHt9kTj1HG7uOqBfPxeI+V/mIks0qTOeac1wl1q8YrLDewwDU0kzz8aONSd3QAebQWNozvB5yR296KOW46Xb2G+5a5dNNiNg4wWm0/Y4HrZj682F+bgeR8jLHZ7AhDK9FXMWAg1iTpEzz+cMoBrzwli00vNipTX6WVCNWaE/pZNoaALNbj+CQrIJr5dHHRDsWMYw/azYVmOT1phBXAlee7N27whvNncxvDF5xVg9P9lJSr546I7cPIQPi0eBwNvv7ULfvyD15eOsM1RlCzKwG5BWuG6r73BAanR5rJriIb77h722a3H/kGzYbKwViU2PhSR0XDeCYj3iumt6u/hFmjnOVRCyniV4yG87xj5TiJGzq4CyqtquQfsj9MBv41fMuo1UUKmU4gCDHU32c1Y4aYyOjNWkirf3fUc72PEVLuOhQ7jozJhmj0SZATT9Je5W+xmZTX6ARYDSV64wPXsqSBxWNsILR5eWhamoyYdqePZ++H4giTwLgFAqLzgjzNjPM15MJhRuBA62/gCeIu6TLifTFoTgQaAUYBBKgEKRgjlolZr194=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199018)(316002)(478600001)(31686004)(36756003)(6512007)(6506007)(26005)(8676002)(6486002)(44832011)(66556008)(66946007)(66476007)(19618925003)(86362001)(31696002)(2906002)(4270600006)(2616005)(41300700001)(186003)(38100700002)(6666004)(558084003)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REtVNHVIbG40cFBDMGlaRkw0S25VK0c3UDR4RUlJMW9qa2d5ZWNlK3E0ZStK?=
 =?utf-8?B?YzlHekY3S3FrbUd1Yks0RStFMHM3dTVLMm1YV0FFVzdJbkpNRXc0NEd6UVYx?=
 =?utf-8?B?eXlaYkVSc2wydHpXWFR2clNjWUthZUdPdHVFc3lsYnd6Z0VON0MvQUU0aWJ0?=
 =?utf-8?B?VlZTY2ZCQURoQnc2Q09jU2d2VnRxZHBxUmJLQ1VpRGV0V1pSU3RRNTdnOTBS?=
 =?utf-8?B?QjN0VkVwZ01LSk16QnhKRnRTWUZoQTV1bXhyZGlxenBRTllpQU9Bc3dzVTNh?=
 =?utf-8?B?Nm5qQVJNTTNwVG9BV0IvVUJvSVBMRnVQQ1J4bnRpZFh6ZXpYV3ZENDJtdG9s?=
 =?utf-8?B?dXluUVlIcVMvKytuN2ZaY01ReXIyd2Vrb1RJOCtvdHFxSEVja2F6aVVDT2lq?=
 =?utf-8?B?dTByQkZHc0dwTmFyYW5UVlFrRUtyaXhMQmNRQmJwTWVsZGpiVVpqaWtZcVBp?=
 =?utf-8?B?amU4bWNRTVRSUnl2RnFkNFRJNkx2R2YzQmFpOG92a2JDRUNqSU5zN2dhN3Jq?=
 =?utf-8?B?djAwZlE2MDFIS1E1MERtVGEvNkRkY2xjZTB1NUtHaCtYbTZySjFid0xXSitn?=
 =?utf-8?B?QWdrZGMzMnVLcHVFSUVob092YTRvUmh6QVZhcnFEV1BMZTk4dTBUYkgwVXRD?=
 =?utf-8?B?VnhRSEJHNktwd05BVEV3TXhKa1J3U1hVL1RJSVcwTUdBRW4veEpTM1k5bU9j?=
 =?utf-8?B?L3czWTRZOHhhenhwL04wdy9Dd0tGTER4eXNhN1BSN25ucUU3b3U0cUxIR1Ax?=
 =?utf-8?B?UW5BMVZHai9mZUxlOU5ob2U3WDd4aVMzaFkvZE02S3plTldWQWd5bkZ6V2ov?=
 =?utf-8?B?TmZmM1QvNVpldmw0bGNFY0FxMmZHRmxQNHdmSXZPSkhRSXJWOUE0eWtPNlFx?=
 =?utf-8?B?OEFOYXVKaVZLb2tNeklMeXhYWm5XdGVzYjBtU0RDRStRUTd4cVllTFRHWVpx?=
 =?utf-8?B?S0VMTE5RaW1sMXRlVFhvc2cwZnAyTFF0dk5MM0VmZTZWZG9wTkNpZzY5SVd5?=
 =?utf-8?B?NHlMYWUyenAraXYrNGloTmRaNU9iNXVOZndaRjhxbjFqWGRmR2NvN0NSWE5Z?=
 =?utf-8?B?a0UxeU42RUdCMmtYY3hrOFhYQkJJVjFpQ3pIUENWZVQrazQxU1lLYTNwZHEy?=
 =?utf-8?B?YUJKK2ZseWZOZmYzRkxieC8zbVJON3BBYkJCRXUzai9vMXdLUVBYQThPeG9G?=
 =?utf-8?B?cjVDeldBSXVBRUY2VWFHR2ZNTDJIQlhoL0kzTHBpY3Rocy9RcW00V09RbTZO?=
 =?utf-8?B?NGV5K2xlL0lDekVHRXJEbzlmYmRYREUzS1RjaWRtcVYycHVYUUw5VTZ4SVB2?=
 =?utf-8?B?elZvMHh1Z08zZ3F0bFV4c29HQWt3elJwOFVsOTJKclMzckE4RU16SUF6bW5I?=
 =?utf-8?B?d1EwQU9jYmV5ekt4MzZaQnhWSUhycTNCRUNVL24rZW9SM1RvaXJJOE4yc0xq?=
 =?utf-8?B?clErd2ZRNG12S1FqZWtEOHduMCs4Ums2SURRR2wweXZtdEtVd050T3ZjRlNW?=
 =?utf-8?B?K2hZZXZ0UklOcHlGQ1duTVFJUDB0ME4rM3lOcUZKbzVYbG4xV1poUmxhbTZJ?=
 =?utf-8?B?VzlGZWVDTHVMMWVMUGlvc1BJbTNOSktTOGVMZ0NTRHRRQWpJMkVxalIzV0Vm?=
 =?utf-8?B?bGN2SDlkNmpEMHp0ekhxaVRsNWc4M1NQQ0Z1ejVqNlo1bDlRRVQvbGZSK1pJ?=
 =?utf-8?B?U3lJVkMyZ3JjTGhuZXB6c2dKUnhCNng1VFhFL2FCVUlBc0p1TzE5WUhZUTI1?=
 =?utf-8?B?ZFlKTG10OUx2TW0zdkcyTmQwa3dTdFNoOE1iN095MUxLRDhKdjgxMlpVa3NJ?=
 =?utf-8?B?MEFPZHdNTWVRcXhrd09yd1VkT1NZQktIc05JTFpJbHJhYTNLNVBnOXlUVk1X?=
 =?utf-8?B?YjZPT2NPZ084MzhoUHEvSkZwcjVwR2ZKNnFDMHdRdTdDMnU4UXNxWjljSWxU?=
 =?utf-8?B?OWs2bGZZTnpmcFQ5RDkwL214cDlCdVNYb0hMMzYvMWdCZ05GdjF3SkltbU5H?=
 =?utf-8?B?eGVYUkswUHIrS3RXYjRmaGVnb1Fuby9iZ0orQlFLSEZZMUJ5eDJpK25JbHc0?=
 =?utf-8?B?dmw0bmJVeFM1N2dQa0k5MDAzOXB5cGEwWTg3ME1qYjZmeE9rbWZhWVRmUEc5?=
 =?utf-8?B?WmZnQWtMQmpDdFp4a0liZTR6b0VLSllteGF2RFVPUnVMSmRUZlpvakJ0cmRJ?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eKDdUMDqvZ/WCWXqHNoJiF43sJHMLUsW0cH/rqONf3o6i2KzbOwW/FlA4h/pbLl18QaBoDGTZnc1zRfyw1RG2ngUrccgny99tNxUoCm+IPsp12PQFCkQFOdw1OHfGinVepCDhnOPox0LQa8r36dQTsoO4phHaWCXiQQ2rv0LVM14JQzZN1KKhsXCbOx/UwyTsGTQnIsxH/zMIF/37toEWLKD/M1OveoZzJy9OP84Xo8hps+GGVQqlsB2Q9x8bRrrAYYN0FManpd/U+yjs7w0CLOjdZXGOrGRx5UR0FLHOW1+wKoxylDIUvkeSSDMFGJlom7mogA0yUxI4a/5VsBQkIU6MvdXK5LaXzViNz+HwIE0l98QRTjkdla3EGihrPrKfoU8/CXCd12hvLeLdHtRRl3of1/sh2Miwz5K0ts5d5ZstBMKO7yyRE5B1eLdUPXBxwsW4wEUNf0gBz6NO8SOYD8qTuWS1j2O5nUToWDeJMSVLVT1y4jawYzkYWobwReEzFlZduWCiTnUTLYqtr4Gdnx5dRdRFRx8zwCktDB8pFK+L4f7WgsP+dP5MJZkOiqA9+FaXXV+tyUm+y+60eOR+uhqvbriJFpxlrHMulqg8TeAfkEOYMjj2FJpNc6vLL/7LVuEQozTe/OqChwXXEhEzL5auF1VNubIZ3WSNTKaOItLpJiM8VCKauDlEjozXKizrWUTYXaFQVDDf+uVpsjDYI6LZ09z8HS+IYzPbwiSOAoHu0DdhqyA+xNBAo/2lAKLqmXbKYljLu56NO9fgFLa3yW2CCl4118S4dK2l31l84g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d367785-0094-4063-c545-08db2a14873e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 13:59:46.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUmfE3DFri0BzeXUSvZO8jm/DZpVhXD8bK6yfyVzN27f2bi1ctNL7uGeizvSouB6BiGR+nfYoEp1KwmJIMiOiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5971
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_10,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210109
X-Proofpoint-ORIG-GUID: ZqFq4EpRBijot9N50UE0T4uBwWTaSgWJ
X-Proofpoint-GUID: ZqFq4EpRBijot9N50UE0T4uBwWTaSgWJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

