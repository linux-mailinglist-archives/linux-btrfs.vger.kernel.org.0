Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0500D6CB5C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 07:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjC1FFb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 01:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1FF3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 01:05:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2EA106
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 22:05:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S4dVth025036;
        Tue, 28 Mar 2023 05:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nPECKbd9deE5BGOdIjdFgFFEvs4X0aCvGuALp0iR/R4=;
 b=uZgm4NYATDp0OwvvPZDN3pjWSmG35lSlA/j+Y0mT9PLWsYQJRk0eMrwYg9KmsNRW1qya
 DKoodcJoHN4Yjk2ihBkKdTUzQ/d7c4o+UWwn25qfOdyV81SP4LGtKMTMgZjzG0F7kH1U
 /Kx7qOZEZuqPA3+2wmzQGQf96YUNmMv+USnYaLajVqtmeffpo3dJo8YsxAVhTSAJQCtG
 EK23k+MVs1SzrvA9fmQKjqvinxt+JSRwyNOv5Nk0/337hxex2wI9LqTqqVzgS3npv403
 kVm5KEgN/Nu9FTceNpeg1eqL4PqHcFp2OfTPNhDHFOpheiTdHaDTzlg0kcDnzpv8ap1t BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pksda01r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 05:05:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32S4rQbX005379;
        Tue, 28 Mar 2023 05:05:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd5whsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 05:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb+lDQUC+mKWSR+m2b0xmeIMGCkglvXKTBEcQxhNR7GGrUUD8dbIpP2ug/tU/4vhBKfpJiDGWi9X8pxmbX3Ar0ZpadNdyFCYbn3Wumj4X1ciEl1Bz1OIglVvCtbUEny1Gmv8WC0SdQI2+YmldBhJXGMUIKzeo+kIS/HWc07BMRro5jEewuY6XASJk3GFl9UXOfxqL7vJ6jykhLB6dxCYZ8LRWPGGDffL/43F6OOZtSe+RD0Kjq0yY/ozmnNwu5X9w4QdCs1zva0kYM7USAj9Ogc59DKPTrwPE906038IIWtZ+9ibMi+bRiOE1u20OzdsUpsTkdGQgHXaSvCnSQEfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPECKbd9deE5BGOdIjdFgFFEvs4X0aCvGuALp0iR/R4=;
 b=Wn7xDDDK4k5kEloJAxDjT48hXwQhDd/k1zaFPIzvyggf8HgQPTy4GyMxu5kfigazFJnnpZerjciSktb915oNWa2Y0f3ajYd5q64axNWh4aDS3u3tK6d+8amkxm2IAmJlsL9TEnQ1tDbM+7VLHT86Z3dKhGvzJC0UukijFki1JAsHVvmoIcmzAab5qewmc3X66Ui7AU6my71IhonaBr9bbMbLzB93mJFYeMcDFqNAdlHQszBDsOpYo+pC4xqnmtHGS22E6/AXBCUs7jNgt6QF3QbASQxV0Zk+3o37nVTppfY90fDp0alKNSasnIxIq0pISEDrVtu1AHCkRjVmzJ1QNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPECKbd9deE5BGOdIjdFgFFEvs4X0aCvGuALp0iR/R4=;
 b=B1WIOkGfwA6faSBF/yI4RuCm+pZIM8aLWofLsiseKcJlbDb56M7ptZSZLAD7MK4Kl1RhOUDCa9XRIqaw7yT7JMgGGPMtRY3m+JLgAoH4T0d/um9Yzh228Gv483ktVYNX4RRWeZLV1+31adM9lsbasJnAzIhkhVz5M5LYQEOgYhU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5804.namprd10.prod.outlook.com (2603:10b6:a03:428::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Tue, 28 Mar
 2023 05:05:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%6]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 05:05:20 +0000
Message-ID: <4eba5d17-ba03-46b6-a936-1d9a9bc55960@oracle.com>
Date:   Tue, 28 Mar 2023 13:05:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 4/4] btrfs: use test_and_clear_bit() in wait_dev_flush()
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1679910087.git.anand.jain@oracle.com>
 <7baf74b071f9d9002d2543cfc4f86bd3ddf7127f.1679910088.git.anand.jain@oracle.com>
 <20230327171427.GI10580@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230327171427.GI10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: cb86d7a2-9684-4354-6cb9-08db2f4a0755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0fsvZ9nPeRFIjMCXCwci9tAsmNgQ1tRwS0jepvq6rh9P0udaVtmDw66JQo4q4fxkO/8QfeUUrbIaQxcPlFoFPBlZXXUMVMUWATtowwCYf6Hp79YYOFNJSjfaoVD7uPq16cH3Hpf9yD/J9vjpvjVNxGW8bq+4I2gHboT8aOScwHaGmg4GAJx83maSxYC0OomTcOUrOz/2aLLsBI69d//GdXn34RrbLmnTJQ48PIvhww3EzU+mq0ESrlj+7d/fSRmv2C55rn8uRZaOFIi5WOVg7O9N0gOvqFzUnD2MIikIBGUCb85vrOVAiXAG2+xRzB5Dw34nl9D3RRTwyq8T662ZgAPX1/i3vzzeyBicAQxhmSbKNRtMoafbAmLshshkDaEdJcN6ZTRYGUIvhMWCu7y2PB6hzOItUINoryASQAK5g4Yj6ageS8EodNmNnsPWXIRfzESlmRe2OWmxN993X3y56MV2iEjkqAzBjrqmJQ9FMmfJdjyuQvksOcVzYas4oNFUB9iyCi44g9V14fop0EN8kSMskfrdl+1A2iDr8PSLqSaH4nQLwZeKhuJhg2G3pYtGmqCSwhqqX1mD1zMQzPAJO9rs9MyM2B3L5qne4OwCVTLvUd6M70C2ck8r/sESUQyawrG768DSuxu1iBeELbf/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(53546011)(2616005)(38100700002)(66946007)(66556008)(4326008)(26005)(31686004)(478600001)(8936002)(36756003)(6916009)(6666004)(41300700001)(8676002)(2906002)(44832011)(4744005)(66476007)(86362001)(316002)(6486002)(6506007)(5660300002)(6512007)(186003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFgrVFNPeUpXaGJJa3lWQ290N09uSExROFBWNzdOeGZHLzBURVVGYWFDQ2t4?=
 =?utf-8?B?VGREMkFwaHNXbjFER3hzRFNqekgzRXdlMzhHM1JGZE4yRHRYczZnbVZIYm9q?=
 =?utf-8?B?d0c1WWN2ZDVreEJsQ0VCR1RNOWZna2R1MWIxbWdNeFZUSXkzczk2NzJmK2Y5?=
 =?utf-8?B?bGp4NTJMaFZ6cHd6cUpHd3ZGdC8yaDdoOTFaeHBnZXlCbmpQSGZMNWFlWUcz?=
 =?utf-8?B?OWJPakFBK2xzcFk3QXl0L3BVZEp3Vytpd3lqV0MwUk5ZejZvWXA4NGE2YnJa?=
 =?utf-8?B?TzlIUU9sVk9tTzBmQ01KdFdDaDZzV2dtQjJCUFF2bTB3ZXEwODlBVVowL1Ev?=
 =?utf-8?B?LzlYazR6a3hhaWxnemR4THZNaFNRMklPS3ZDVk1tSU5IdVRyNEw5MUJFU1Yz?=
 =?utf-8?B?ejYxLzJIOHRNTFJKNEJJZVhRQmtwa2tSaG5PZkErZnVJMEZ0U1BSSnJyd0Zz?=
 =?utf-8?B?ZjNPMmdGM3dMVnZRc0pteDd2VVBCcjVSRU5acXhQL0FrbkY4Rmh5WHdOK082?=
 =?utf-8?B?d0x1dTBjM2ZDazlUNUpsMDFiNGFOb2dRaVdrTVV5ajNYTGUyVlp5dnJ2S1Vr?=
 =?utf-8?B?OGEyVVNhcjJYdlE2VG00NzhNazcxQ1FocmxJaTlxT3hQMlVFNGdsYlZZamli?=
 =?utf-8?B?UDVqWlVDdzc5RE12dVEveFNiZnBLUjVyZ3dJRFRpS0xEQWhDUUZJRHRpNVIr?=
 =?utf-8?B?RnhINTREMlBjYktCRml4b0dQRlRuRVlRbkpnYU1FMjgzWnM3UmloTURBTWJ0?=
 =?utf-8?B?bHBBZ1JZYllkS0s4Qy9kbjh3eW5oOVN0eFFQSXMwd1BwNHpObm1Lc254bkla?=
 =?utf-8?B?VitJcVg2K3ZFM08vL3FYSkxPNTdPRG9LQlo5bCs2dkErdmZtSTFwa3RKaFFY?=
 =?utf-8?B?SWVCZWNUemx3ZDRtUDlrdTBjd0ptaDMzYW9wYkVlV0Y0THNveUk5R1BlZXpm?=
 =?utf-8?B?NDNScC9pU0Y3VnhMYU5TNTh4dTNoUDNHZWF6MGtEL2hSYlRpSUV1dDVCRXpD?=
 =?utf-8?B?L01QMXEwUFJnenlnNUVEUmozcTlpalQ2WFBJS3lScjJGN0tWOG1CcXM1WG5m?=
 =?utf-8?B?azlQMitlanZrUTMyWkM2bDJxUUNxVWVHVnIremRuRWQ4MnAyZzViNUVFamhm?=
 =?utf-8?B?N1FPQ2dmeHRGekNRUFRrYU1hU1h5S0U2Yys4WmgzdWNJWXl2VlZuWGJDUlFw?=
 =?utf-8?B?UTVaMnl5Y0dDK25tYlRZazgwMXYwR0txRnZwaE9PZWlNRHpEcTA5TVVkN3FJ?=
 =?utf-8?B?Q2g2Y01UWnFRZ2h0djYveTdnVG5BWUFTNmkzbmNGamtjSTRvQkErOGVHMjFQ?=
 =?utf-8?B?QTJmcDA2RDc0QjczK1ptdzAzSlV5bCtlendSZmNQTi9idTlsb083ZmpoZjIy?=
 =?utf-8?B?NXRNb281NEVtMkhOaVY0SnpSYzR6N0xMRVhvMXIycmFrOTlvOFpRR2NSRUx6?=
 =?utf-8?B?VllyV3ZJWUhUUnNrTnVNWm1QQ0ZsM3RFM0pBdjBwNW9zY1d3dzlnZ0lWQVAw?=
 =?utf-8?B?KzR0VzZOd2pWQTRGRWgvZzlXR1JBRFBLUzh3TUlvTlNwNG9RbzBiMDZJVkp3?=
 =?utf-8?B?RFZ0VXlseEFDUHQyY2VJdFdlanVoeFVsczdGa1h1dmJJOEs0cTJ2NUZ5Qkk5?=
 =?utf-8?B?VHREOUZVMitFR2I5NHoxd1JWUWhBVGUyajhLUVo4V21yNVpiUkpWZnhORnVi?=
 =?utf-8?B?Z2VHcFZJVHFqaDgvTXJhaGIzdXVqelFrcnlpTEtsTWtSRE5MY2NSTGJ0U21n?=
 =?utf-8?B?a0g4K1F2YzJzdlFGSFljVDZwL3QrWEwxaVpXdXVTOU9ObnpvNVk3cFhSbDd6?=
 =?utf-8?B?WlNndmZBNVVWV2wra1FNRFdocjlNa0pkTjZod0k0ajhvUFJmdkwwNzlqRlZp?=
 =?utf-8?B?N0VMUG1FMFE3NWJlNTFNdXpkT3d4d3BLTCtiRjZnSFpmNlUra0tBc3pXbjlL?=
 =?utf-8?B?amhUT0J6dXFXMDRaTWdOS2V5VEUwOEFibmhrWHN6TlJldW04Rm04bkgyRk90?=
 =?utf-8?B?VDI0TFNIUEVhQWxndEs0UURWZmpKajdwRlN4MW04WWdaZEp4ZzNpdGQyWWl1?=
 =?utf-8?B?aDBieVRpS0FxOXFwQ0JPQjM0U3o0eVRzWU5xbXNRemxwWmwwcWJudjJhQ0ds?=
 =?utf-8?Q?DWIC2gxehFqSannqAak0XBOez?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1vlC2T0/I2TILFVHQ5hHHIuyqXPWwciSXs4gcptXOqKiuxGg0GiIbIiF3S6FY7SE9kastBNcI6wdgvN/5bsP15VUeldhEWxfA7xPHgs5QkQZdDK3eHeHzKZ/eopuf2bOqkD0DS5rmXRoiXCi5dTIr+akXtrHU5+vaOsHgLtFntkbtB0mGpgrOzRED0uh0lR0ANWmOnwfw1asG1S0MUcbAzJVhErvLUAzFJHKjlvZwD6EVVHozENUofiislaf/esf11uLQhOB8D04YooUqPBPHbu4DDN/oejiraxKK0A/qhajofrCDIHwscacU+iG4QdcDRntkcoe4EwrR8Po8fi6+fzJxVpmziKSXbv3FHiRQkSVmWYkYSl3msNBZegmf/pK1Yo3fPsfY5yWh5pOe5OSs8/7vW+VOifZCLd0qrpUPS8OmRcP/+ZoIgkb38DmGeltN9gPF+V4EpCm+Pd9ddrc5oXcYQN0huJ+hD/VV3jz0xdgULg5x13XlMpjO6wo7N1qDLtp04+Ca3kcpByvnb70axOjEID7qfloHUuI7T0YL0fmZbbX3lbMiyShmtr4+AXghVO0QeAjv4EIV14lXDyxGyqcLb6+WopV6ljlWKM0EtS4kj6nX9wMzfR92MsfCjzP1avvsFF+Kkon0gaozyy4IkhUKZ9v3lnhm5KNvgdxdCYeSLYZPj5nbJN6JZXUCHLx7XgdGuZpw0AlF0b+4ZyioWV9xBO/oi8AyAIFbiYv2FpTzyJeJFm9nUvkuM9sNulrzt1PXvFtvY5QUDDZeD6QRcxTTFLmNerza8QcDgirVbI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb86d7a2-9684-4354-6cb9-08db2f4a0755
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 05:05:20.2837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBgZoxZq7dC/ZhA8VGsCnk0loin4cXLA/o8jg7os7zggImJ9xB4tONO5Kdzf7tJk1MyIv0SZnfofvPztBeLE7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=844 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280040
X-Proofpoint-GUID: ywVzvS_gGkZEbDXZqVUtgrrl6QeQsMen
X-Proofpoint-ORIG-GUID: ywVzvS_gGkZEbDXZqVUtgrrl6QeQsMen
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/28/23 01:14, David Sterba wrote:
> On Mon, Mar 27, 2023 at 05:53:10PM +0800, Anand Jain wrote:
>> The function wait_dev_flush() tests for the BTRFS_DEV_STATE_FLUSH_SENT
>> bit and then clears it separately. Instead, use test_and_clear_bit().
> 
> But why would we need to do it like that? The write and wait are
> executed in one thread so we don't need atomic change to the status and
> thus a separate set/test/clear bit are fine. If not, then please
> explain. Thanks.

It's true that atomic test_and_clear_bit() isn't necessary in this case.
Nonetheless, using it have benefits such as cleaner code and improved
efficiency[1].

  [1]. I was curious, so I made wait_dev_flush() non-inline and checked
  the ASM code for wait_dev_flush(). After the patch, there were 8 fewer
  instructions.

I'm okay with dropping this patch if you prefer to maintain the correct
usage of test_and_clear_bit().

Thanks, Anand

