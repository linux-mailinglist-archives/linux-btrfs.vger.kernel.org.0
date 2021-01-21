Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2683F2FE80C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 11:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbhAUKqU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 05:46:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49872 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbhAUKqG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 05:46:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LAhjvQ168056;
        Thu, 21 Jan 2021 10:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Hk8Otcv1rsFEiHmc2q0AwzivF4WaRJL0SCUygAJt/pI=;
 b=NIAzyxjZXLJpO9+bDfUoh62sSiiBMzoEhU3jMDw32+EGBXl5kwty9lSP3+9IDrcMhpmX
 THo7TnCm5aV5HLP/mWWaYwjXmT5Gne5bKVtUcmK4W317+ua7Wg8lEuIKVPfCNT4ZY+/0
 CQ+iGpP3YMvosP6Zdve957jQkEp3FlB+Wn1aWPyRfCggrsmslcsiFLnoP0jAGUdgXw2K
 rCAWRCDFu7KnQ1Bymc/aoYM2geFNRRjYnhWhtLFhy5YMWCX10ifS6OWLa23+6Iu7pfZW
 +GyyHVv6RqiFFTS/7wwFK8XRvESQA2yV2pT+cqUVPO9qD9xSBK/bhzQ2GQB+pBMbJBRH wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3668qaer2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 10:45:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LAdt8a051926;
        Thu, 21 Jan 2021 10:45:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3020.oracle.com with ESMTP id 3668rfg4r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 10:45:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OorJlOqBl+QhoqNSWlo3T0u8JA3pcvSPDKokufBBWzxJP+7EhJxgC9lhCSgQV0OCCb2Vp0qeqbk74EgLBqtw/bVkgRF75e+Ha59BSyqAXEEU90uv3zTLsaLR/Wiuicpki2lPs+UdhMgw9ganq5TPS3xaJfnBRNSLRbuxXtYiW0twdocmlRAdXeiqh/tD/CxneJqGFJ4Sz9LTyQsPqr8qsxWJAIgFAhY+RLgOU96cwD6X8xvrl4sGG0Qjt0Z7/Xf8g2/Mil5quLYCaRL2lLfuDq+B2tPrq7SkUVrXpjDMwH5n8Y92cfJ2WWmYyxy058MfY13GWjpkPuGgQvToznZRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk8Otcv1rsFEiHmc2q0AwzivF4WaRJL0SCUygAJt/pI=;
 b=SeDTLJIb87jyx/IWPLwlAzKbTudbsGYI9IH6MqqtMgvoWW9zqqTRhIGEF/ZlDv8DSeaxwhV0s2Qju9hwJo55y5V3u9BkaAdz9rgFQKalZ2thehl9o/KjdJvdpfKFs2UDhb5VJ6T2AB1zcAgrAJCC4VpEPJJMm/IelUQH6UCzdHQaAXXI6XHBxnXXz2Lz16VuhWbZpy8XyqeLy/+0nQ90FSmXN6w0sHZGNAoqWtMoDOGY4c8QdDNrxCP6zaDpFNmqNhDeFwGmk4L0dZx4nA4YgTBlr7hMVVUllp1Ev+0rGBOD8Gq4a3WHu4871EvpI6GwCT/hOrLelU0f3WgMwuTf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk8Otcv1rsFEiHmc2q0AwzivF4WaRJL0SCUygAJt/pI=;
 b=OaPHGNzHyW8h0CUTKNXx4WdMKYBOBqASCtyeGuDlEZN1MYpHYcoZEgNSo47iRY9qZG8FOl8sHG5mlCBRpT0QRp8SDie5MAkX1Z6lPxM5cH7oAo+11I1scuQGZusHutU8JDD6W9YeMP85D56bCgyqmHBLs7fFYStdOX49fv68T/I=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN0PR10MB5336.namprd10.prod.outlook.com (2603:10b6:408:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 10:45:12 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3784.012; Thu, 21 Jan 2021
 10:45:12 +0000
Subject: Re: [PATCH v3 1/4] btrfs: add read_policy latency
To:     Michal Rostecki <mrostecki@suse.de>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com
References: <cover.1610324448.git.anand.jain@oracle.com>
 <64bb4905dc4b77e9fa22d8ba2635a36d15a33469.1610324448.git.anand.jain@oracle.com>
 <20210120102742.GA4584@wotan.suse.de>
 <bc5665c0-f066-39af-48e2-dbc063b260ed@oracle.com>
 <20210120135457.GA6831@wotan.suse.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c2b5daef-3d53-257c-3769-5c1f4e3ddf09@oracle.com>
Date:   Thu, 21 Jan 2021 18:45:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210120135457.GA6831@wotan.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR04CA0176.apcprd04.prod.outlook.com
 (2603:1096:4:14::14) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR04CA0176.apcprd04.prod.outlook.com (2603:1096:4:14::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 10:45:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c850f5b-22ea-46ed-d80c-08d8bdf9a10d
X-MS-TrafficTypeDiagnostic: BN0PR10MB5336:
X-Microsoft-Antispam-PRVS: <BN0PR10MB5336512A40955EE73C36313CE5A10@BN0PR10MB5336.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEdvlnjAV1iu8qWFinzlKWu5+ZMf9NUcfADRke5QKhX7FE79Y0WF0HsbkIrsezr8r4kpwZo2uxW8i3dOVvY7SlWldkADxHX3kYHtcRrPoZl2EQQeMHnlZqfxecCIymlfg7jjlyOxDbJKbza7B3axrm992MFhTVQXTwy798i5rURbZSdOTcQiLAZopN3F/P1/H+zo6DgUIRjFSLpYvmQTZfOCykr0XILLSy9xFvvSbJlsCtHdbzuE3VYOIVUelnWgjlOJ0wdShn7s0EhUfk3UtoMmbsryNpxFPVRIX761+KUn5kQ/7F/RNEk6hPhhT8UaXsPODR4CPynN0nXEZDwXWkJ90CZNd/iidKwyqKi9xNkEzd8z/RHSlI/8mAC+kI/lLScUgO923I4+bcJzQnTdiXe+X1f4PMChzxqTN4SJ8B1jYm8VfsbUwigyLuIWbHUaojsIUhp3FlpqNOLNyYSxBg8JZj0GDZbE0icEHf9/Ij+l88lTsejvsCIaPxRFtWvTQfmIvvd3ILHlv+1OZe1lD/orRo7+vNaJHjnCLIUHnbqN542mBmIODWDz8rJWd8yP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(396003)(366004)(316002)(16526019)(36756003)(966005)(31696002)(31686004)(508600001)(6666004)(44832011)(2906002)(83380400001)(186003)(8676002)(86362001)(6486002)(16576012)(4326008)(5660300002)(956004)(53546011)(2616005)(66556008)(26005)(8936002)(6916009)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S0lMUklrUG5oRkQ0bE5SNVIxbVZ5VXBkUFE2R0ZnanVVMUNzVTR3cWhzcy9W?=
 =?utf-8?B?SFcwM2JPUjFYajV0MGdiUCtITlRnajhZU0thcm1tNmlhcHZKYmF3Z3NRVDgz?=
 =?utf-8?B?U0c3azJxVXhRUkVTam56OUFPMHlKYnVHZ256aXlrUzl6ZER1TEQ1QlkzN0FC?=
 =?utf-8?B?RmRtL2JCVHVBd1Q1dHJadUkzdGZwZTA5OWFUa0JuTStkVlI1bnVKYzMxbGFh?=
 =?utf-8?B?Q3A5YzVteTFSRkx2cXZTQjJabHBCbDRndWovUVMzc2w5dnRTUzRiRjNEVU9l?=
 =?utf-8?B?Z016bVBpeE5jeXBuTXdiMDRmMzl0L1FpOWFCWXY1cVJRTjRPcm93eDgySUFD?=
 =?utf-8?B?TFJPdkMwUVdiVG9mYXJ2K0t0V0RYSDJFY1FDSTVtNmIrL3QrcDd0cmxJRkJ4?=
 =?utf-8?B?UU1BcGgvR0V6UVVCbEYzNUEvSDRSWCt0SUNOb1FOWUxMYXV3ZUx2NGxBNHB0?=
 =?utf-8?B?MktHbHVKTHU3blhuUUh2ZGtSWS9hRlExQUlZMXJyQ3lSaExVbTZPL3RGc0lw?=
 =?utf-8?B?L1VBSWN3UTNEYUVmenNsNlh0K1BNYjFzMytpQXVZb1g3N3N3MlhZU296V0pT?=
 =?utf-8?B?Uno3cXVzeWQvajJwdlFJcDRnR2gyTU9yVmplbHRSb2luNXJhQ2N0akVMNXRh?=
 =?utf-8?B?eEs5RkFIR2hjZXRDSkg4ckhqZFVDUTNMcHV2c3Y2REJnUGNMU2JCaWdHSDB1?=
 =?utf-8?B?N3laZEtGUnFxTy9kcW80Yno0UC9XYzQrNW1KVGZnM0hUNDZRZXp6RUcwb3Vs?=
 =?utf-8?B?NC9nUTZSRENXN05LZ0Q1cU5LcXA2a1FrVWNXVlcrdmEyL2ZRYUEyQ3I0djVM?=
 =?utf-8?B?N0xDME1mOE01QldldU1MTEpzZWVjV0IzN1I2eThUMmRyNlFDVE5uS3p6Wkx0?=
 =?utf-8?B?clNJbHVUb01idDJ3TU9MRlUwZ2djZHZNeGNkeG51T05vS2tEN2dMMHFyVzNt?=
 =?utf-8?B?N0s0cW9XSHZKQjhscHpQUTd2WmFVWm1FMDMyQzBGdE1LcEJsbzFoaVpKa0o0?=
 =?utf-8?B?aTY3V3I3TjQwMTVTZVJKdFVDSEMrNG9xejJ6VjF6Q1pXbkt6VHNBQzNRSjNG?=
 =?utf-8?B?akVDL1lqVEJqYmhCRGlCMFlQK2g4dVhoUThxYWFFOVBEQ0xzeU8vSDM3ZzRi?=
 =?utf-8?B?aGNMTWlCZlB5b1hnbVIzVDA5ZU1Qa25YaXQ1bVJZemwyWWp2bWxjdUJmUHNt?=
 =?utf-8?B?ODFYZEoxbzdLVldvdndVY21adS9jR3l5TTg3NHpLOUViUHptTkpRZ2E2S2dJ?=
 =?utf-8?B?QWF2U0FibitDaXE3TFRlWW9NSWJLR2x2T09PUThKYUduOTk5VytlRm10TWda?=
 =?utf-8?Q?3NfkYlfifdJa2AVokwervJuDHtNQi1JgCv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c850f5b-22ea-46ed-d80c-08d8bdf9a10d
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 10:45:12.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gIsCHGkyD8ftN8qImpmdzu76kQPKx9bdIxDmPRz5LVB1nJ2fZAUGR+JW9E3VeY45QSSE0+bhaZOzXjx9hZ6KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5336
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210057
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20/1/21 9:54 pm, Michal Rostecki wrote:
> On Wed, Jan 20, 2021 at 08:30:56PM +0800, Anand Jain wrote:
>>   I ran fio tests again, now with dstat in an another window. I don't
>>   notice any such stalls, the read numbers went continuous until fio
>>   finished. Could you please check with the below fio command, also
>>   could you please share your fio command options.
> 
> That's the fio config I used:
> 
> https://gitlab.com/vadorovsky/playground/-/blob/master/fio/btrfs-raid1-seqread.fio
> 
> The main differences seem to be:
> - the number of jobs (I used the number of CPU threads)
> - direct vs buffered I/O
> 
>>
>> fio \
>> --filename=/btrfs/largefile \
>> --directory=/btrfs \
>> --filesize=50G \
>> --size=50G \
>> --bs=64k \
>> --ioengine=libaio \
>> --rw=read \
>> --direct=1 \
>> --numjobs=1 \
>> --group_reporting \
>> --thread \
>> --name iops-test-job
>>
>>   It is system specific?
> 
> With this command, dstat output looks good:
> 
> https://paste.opensuse.org/view/simple/93159623
> 
> So I think it might be specific to whether we test direct of buffered
> I/O. Or to the number of jobs (single vs multiple jobs). Since the most
> of I/O on production environments is usually buffered, I think we should
> test with direct=0 too.
> 
  It explains the stall for now, so it might be reading from the cache
  so there was actually no IO to the device.

  Agreed it must be tested with the most common type of IO. But as the
  cache comes into play I was a bit reluctant.

Thanks, Anand


> Cheers,
> Michal
> 
