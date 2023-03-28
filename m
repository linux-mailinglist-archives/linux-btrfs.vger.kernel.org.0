Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31206CB46C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 04:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjC1C7R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 22:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjC1C7N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 22:59:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1121BFF
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 19:59:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S2tGvi030363;
        Tue, 28 Mar 2023 02:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4+H4d0/+BqWqiuGq2ButMwUe5e+u9wIRjq7W15NfUz0=;
 b=GQE2lD/22OcsLSHfWRYqaLapKM6K/UqS2rtzL05CakBD4B3GsSieLQz8zUq5qD+4amv5
 lciGtN/d0uFyvHsiU7G4XCcfSFs+mL7Tr+jKrBZCCcrNxWoaliFjBiA+7YNNvrw1QZ4j
 sN6ChULhTpGybTo2KdgKhSNemYpaxlQyxy8KAf8E7l4h/y79XVVj9cUFGGzsSew1SnV4
 hydxlZrcrZNGnzZvnr6dF3gs95cOQkSXKpAaP86HQTlf4pVqZ4BbyZDi8ObpOhDiKJ1N
 qSdB6p1VlOw7tXBcfGTF1HnmcF9udN4Hl+sXVZ0CvfZfVuvGBjmYUa9aJEdaJr6ByQpn fA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkqvd00h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 02:59:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32S0FhQJ027099;
        Tue, 28 Mar 2023 02:59:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd5t94j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 02:59:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lv/mtrHpt/UbLY/aoNp0wt5ME4OfF+E8SMcnIWIt+nKF34W00/Cz50w+ujhcy4Yezclw1YsDV8nJOxJ+XCpD2Tx1+Hs+V790om/iWikE/x6cOQtUa5GLxLfih7nHsf+UcvJ9RWi3rD9EhsTJksKQ41LY3Theb5DDdjYckB+YAKaH0zfu+3vOVhq31mL2h34JEZ7Er3tkVilsPqk+pk2SRzlRitwp+j7Y1mMeiWpF3RvsMrqT++EoBGNGgw1KmFRLmRlMp/04gC7Hf7gsfiWRzp8nSLOic3GRsWN/sBQqvUM0XbTTd7EjYPKDmXr/5+cZfXJw7pdp5+HQwZL8+DB+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+H4d0/+BqWqiuGq2ButMwUe5e+u9wIRjq7W15NfUz0=;
 b=lzXGuiPbRe9dAkrI2sMPh6Z7wy0JE8xoDBP0dR2S3vi64lX4By7JZKdGPM9uK5Ny++NjX9sxroS5N5dxs9n4uOdwA3qlRn7Z78CLGyP5FxYaYBCCYXpy/VEuXk34ntOead95A2HPbTyMN9l+mgIL7Rk2WHi8MOqUnZzo6JJZn/PsoIXDrXbTxVgyrKIRwxv8T8mjGQh+1T0tmkPJcUwkGiZvAUcn+GXZQdCmiVLifvnRkYqLdAcMqdQKIdfAQZFzJ4pkn/hv26GlwUI+dda/zfnN5D2nvK0SbchFbRTH02ZuMANXcsl7ElsrRB4r95DijpqV3u1LeT5BLoMyR5IuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+H4d0/+BqWqiuGq2ButMwUe5e+u9wIRjq7W15NfUz0=;
 b=pWGqig606rRxZ1Wao7gGoqOKNye66BiVypHemlPsiOtIwdxCK2irLz218ad8lXB7gH0trmzBPm4j0f6MVyyWwix3T/uzcow/Gi+DC5+0CqKfnCJB7hKVZjrcEIeecLCT3Z2Kbv89tKNuJqFLozOfkwEd9rgr57sKdI/S4Ie2qnE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7259.namprd10.prod.outlook.com (2603:10b6:610:12a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 02:59:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%6]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 02:59:02 +0000
Message-ID: <cc29cc5b-b556-425b-ec3c-3f88fc3cc51c@oracle.com>
Date:   Tue, 28 Mar 2023 10:58:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 3/4] Btrfs: change wait_dev_flush() return type to bool
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1679910087.git.anand.jain@oracle.com>
 <3e067c8b0956f0134501c8eea2e19c8eb5adcedc.1679910088.git.anand.jain@oracle.com>
 <20230327171144.GH10580@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230327171144.GH10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3379de-e8a8-44d8-5777-08db2f386229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ovg7iSM41N2hIHC6Dv5pWFP2go05OIPcCX76zjrqy/GsRaFxtrzzuAIJ77fP6RiIIHCPEJa/DCeRpeXQJjiGT3MFrUHorCMnVCEiXajRSXDvveqUITnhPGXUyhdiD22uPrXBr5G6pkavrefF0pQ4zLbhL3yo/EkedO0lbNHoC3FZRwy24lKtGYCpyl5HgM0FFNV6ElKe0JMY9UUDFO2NF7B7laSQBGLj7e53TJfz9KTpgontmqGPzdGHHEt1u9kfb9OwOONAF3OBenpa3I/whpeeRyR8SoQwSDx2Gy/GGQxoecY1EXcEUk7qK1We9M+P8RECHC+K4wQxV8bIoNUFrnQaqbhoxCRt+55M1NXNwPmwlwpcAjZ/aOERrcxQ0dDqMHbGqe24+ehKuvv68CdNGH/wPchsn+6EKZqpi/mV4EUav5BnDWD0yQdaNpA+g1dpTi+ubMwyrfF83odKNhKmfqrK0JAQyghGR6nwCU6D1fkOSfakAl/aK0wX+ZQhPbIO+Ea9EYMmZPu4cIIKw9uh7um5NxSdxY5+GL3RXmRnLGvLgD2ibGSYu6kyjKXwZYFgZjV0rg0wRvG+Ry8ju2AqSw1hdztJv0GYoPt7+ybtDBggU5YB3T98yOijqAWowh2ON2Hr+uJgeZ5z5tyRY9g9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(6486002)(6506007)(26005)(31686004)(6512007)(478600001)(186003)(8936002)(316002)(6666004)(5660300002)(41300700001)(53546011)(2616005)(44832011)(83380400001)(2906002)(4326008)(38100700002)(6916009)(31696002)(66946007)(66556008)(66476007)(8676002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFZ0Qm9tTjduKzVHbHVjcDJSMm1YdWZWVC9RTDVNbXcrSER6azQ0MGM1QmJx?=
 =?utf-8?B?MGdMbTlmckJYV0M4ZkxZSkpRYzFVY2dIQ0VMRlQ3N3NPbldJWWZmZktvZ2wz?=
 =?utf-8?B?SnJna3M5R0Y3YU5ZM1lUWTNoK0RIekpKZDlrSDlocEhtK2FoQVZSTGFaZVov?=
 =?utf-8?B?R0NXdHRITHAwNCtMMzA5ZFNWa0RjaE9tU0VuemFPVjNoam14TEltVkVmcXpa?=
 =?utf-8?B?bVdGMEtLbVhpTVlkZlRHcVBteVd1bHlXU2ZkcmN5WmtKTUlNTFNueWRoRkh0?=
 =?utf-8?B?Qktwa3Bub0JBcHFtMXVBUks2Sml5d2tROHR1MzRoSTl1bFMrRStrRGZzOWVG?=
 =?utf-8?B?KzloZUpGQUREOWhCY2wzMENNYTQycUdKSUdmMUlwbmdVZlhyNnhkN09ybis5?=
 =?utf-8?B?ZGxTUlYveFh1WCtnbXlsUXQwcG15ZldFKy8rWjRycUdVeER6d05BbmV1dU80?=
 =?utf-8?B?aDZLeU9taGt5UHdSQU1wd3RVV3kvbURISnRYVmg5UXdPdTdXMXJKWjFSdHFR?=
 =?utf-8?B?TmNrNG9ZNEpZbzdKSTJxTmd0QmlRRjBReDg3SzB0WUhHQzN0L1lYN1FJWTNN?=
 =?utf-8?B?MFVoUUJjYlVncDRUTktmdURJRzY2blNpajZTcm9rU3hMQ2tsN1Q1S2NPWS8z?=
 =?utf-8?B?dkxoV1U1SWh5Q1Q5VEVXam9pa0FyTkdUbmQrWWNjZTF1VTN6bEc1Zll4TkJI?=
 =?utf-8?B?d2MrV1c0eUJXbE5nUDJuYnZBUmRqTXhkZFRHNzhwTUtTK2tPWHI3WWRVTGJo?=
 =?utf-8?B?cVJ3d0lhMlhKdHF5Z3d0djJqdGZ6Rzc0dU1EdFZ2QkpnZ0VOY090K2RkSXBa?=
 =?utf-8?B?Y1ByTTZFbkZKU0RRcEova0hPbmZZNi9TeWR5N1pIYTdqSzk1bjc5N3Z0WW5Q?=
 =?utf-8?B?UEpqRWtKS251Q05UN3VaL2gyQjJLUW1ZS2N6M0NKRWVoMUZLa3FtTE94RW9q?=
 =?utf-8?B?OUNWc0dWVWJUNnRqeHpMWi9jMFZ3SXp0L2NpQk9KOVVHcUlpU0hnR2FEYjA1?=
 =?utf-8?B?SEVueUVzaDFZQXphRkdpYXNrM3hydTZmbDZzY1U1Yk1tVFppUHcwcktYNFA0?=
 =?utf-8?B?V2lxdFZxRG5XMEpKYy92Sm5aaGE5MktSS0ljZTBxZUFNRUowZVVZRSs5SG5a?=
 =?utf-8?B?SVVuL21uVWt1REtiblFoZmNNQXlGRmU4QjVJVHk2SVJ3dGh1a3FZd2FRWVNa?=
 =?utf-8?B?aWhnai94bHI3alNka1VSUVZRRFA1M2V1N2RjYmFlRTdQK01LY0FLSXZQZjNk?=
 =?utf-8?B?ZUZrVlVCdTdqN0grd1pnNFpsRzNCc1Q4b1gyY2lMTm50T1BrV0R2RXlrOE5q?=
 =?utf-8?B?SFFxeDFETGRBOTVjYVdqL3V3S2tSVFpWY282TklNMEhHUDlEM2FDN1MyN25K?=
 =?utf-8?B?TElReFo1dWUwSXduZHgzdDJ6b0ptUHpaeTV5OUErbCs2Q2NQQktTN055QThU?=
 =?utf-8?B?MEVRcUkzbnJUOW94bGdWQ0N3bit3WERYRWgyc1J0UzF1dktvczI4OWhzL2hr?=
 =?utf-8?B?Qi9ZUUxDa2hTUzdNWi9sZ2xOQVMwOVhnZW1CVTFwVUdYcWhTRDhOUHlBUlhx?=
 =?utf-8?B?bEJvQzFmQnJ3MDNhQ1daREdQTVJpQmhLS25melRGMHh2ckIzTm9UVHBYVnkz?=
 =?utf-8?B?T01sSFBLcWxrejg5K2wrNHdBN0hoYmJqSlBIdHl3clVxZHFLM3RxM1pReHR6?=
 =?utf-8?B?OXNwNzNxWUV5aDlrSXl6aW9YeTh1dDhYY2NJWmZsUEVJYWNrSUF0djlTNit2?=
 =?utf-8?B?ZXQrckpTd25KSGU4SnZBRytpZngzc250aXlwamN3OWFCYm9WK2lCbEZSMWNZ?=
 =?utf-8?B?WkZDcitQSzJnZHh4UUlXeE92bUVnUWtET2J6blRWUkcvNTZkUXNTSjZpb2Vo?=
 =?utf-8?B?UDVlQ3ZsdnRPSXRJMVNhcU9obDUxMDNnOVRLNjZnUDhJeUdBTU9NOXBjd3lC?=
 =?utf-8?B?TTlMdTNyNWlNWk5UaENsY1dDa1V4dTk5bXJQWTJabXhwTDhTUHE1WmZEQjBz?=
 =?utf-8?B?eGl5VGI1Z0xoUGphWGRBWEF0VWVOa2VCM0traWVYS21wdzlpNE1lOUZET05l?=
 =?utf-8?B?UVhndGxEQjFneXd6YkFyVjZnb1VhWFZ5dzJaSjNPQWhtMjFhTmF2ZGllU1J3?=
 =?utf-8?Q?eDvG1ftFVibyv2jBuGDZEg0W5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H/bvr0tllT9XOLEaNBApzXZohKvIe3Yf/Jr7UNeNVAodeWRWHUfcIEVsX4jvqOC6tCvYEFE6tp0/CmnT8f/zouEbuZO1J9ow9LJ4ImBbCJj8u5cZBQVblq+MRfENADHUCfV+baQuHJPyX9lRzCExIfH/UYanBHBf2wvHXe9jO1AXwzWAtJiAjwU6bl+h5+8dw2YiAfD8/TLFlPL0J86eWXaILv6dn8XO9oEuXaYcgoPGKldzBqBRKa83+XhkbpYqtzsPRhHbA6nRnUCuC/rl1SJ3VYT9Gnc8Anq/QkQJO0IvsMDTUTqAZF0MAE9z8dIcGJNDlV7Mdyvy1bO3jL8yJwBm71SqJUxsjmaWH6a1rLxJKTfjFOzD5redqph28w5pheGkKb5f1SDDHmcT1PSWQZtgijRWRezqDt+prMGIGRiwUd8uDNWnoGPYlkyskaGq4xxfBtzXBGx1MM/QHqIj/8yMLwjiiBZwKUiwCg0iWg+wcNgQPIE3f34bMQcPQOz2RD3WjZl30Y3gy56llbOql0QRVfqqscERNN4bYsZJK2Hb94d6o5CxJIDMBdhjYHk+UM24tbe14ZeTu5PAeczXk79JvlPYt+flzMxU98fwFbtF6x13zTc9Xi3rbY4QfRVD4d6dALf6LB17oWDc+iXkCLearuHH5KHzQiN0Ezp1bf2LKVhZF1QJSJO6LQBSELl+YWDa4ZP3hTXvxi9ZSrw5WHI49QUIozO73lBLGhS5se0fbIe6psbq7M7sxODmdtbvwXEej/2m4aIntatbeDQLsYFRBuVs2Q13eIfrzA/nmbo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3379de-e8a8-44d8-5777-08db2f386229
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 02:59:01.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0x3QC5cxwgSip4XFW4F4zdr/URKQAzIUGxogoCOLDV+fCFCgZjB9YuXdqIWbav34ZpMTUBBCK2JpwhK/XfsuVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280022
X-Proofpoint-GUID: 17zne35qyhVOhpbzFMSo9yZb8Jtrkh7O
X-Proofpoint-ORIG-GUID: 17zne35qyhVOhpbzFMSo9yZb8Jtrkh7O
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/28/23 01:11, David Sterba wrote:
> On Mon, Mar 27, 2023 at 05:53:09PM +0800, Anand Jain wrote:
>> The flush error code is maintained in btrfs_device::last_flush_error, so
>> there is no point in returning it in wait_dev_flush() when it is not being
>> used. Instead, we can return a boolean value.
>>
>> Note that even though btrfs_device::last_flush_error may not be used, we
>> will keep it for now.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/disk-io.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 745be1f4ab6d..040142f2e76c 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -4102,13 +4102,14 @@ static void write_dev_flush(struct btrfs_device *device)
>>   
>>   /*
>>    * If the flush bio has been submitted by write_dev_flush, wait for it.
>> + * Return false for any error, and true otherwise.
> 
> This does not match how the function is used, originally a zero value
> means no error, now zero (false) means an error.
> 
> 4152         list_for_each_entry(dev, head, dev_list) {
> 4153                 if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
> 4154                         continue;
> 4155                 if (!dev->bdev) {
> 4156                         errors_wait++;
> 4157                         continue;
> 4158                 }
> 4159                 if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &dev->dev_state) ||
> 4160                     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))
> 4161                         continue;
> 4162
> 4163                 ret = wait_dev_flush(dev);
> 4164                 if (ret)
> 4165                         errors_wait++;
> 4166         }
> 
> So here it's reversed (with all patches applied). You could keep the
> meaning of the retrun value to be true=ok, false=error, it's still
> understandable if there conditions looks like
> 
> 	ret = wait_dev_flush()
> 	if (!ret)
> 		errors++;
> 

  My bad. Though I knew, it slipped. Thanks for pointing it out.

> Another pattern is to return true on errors (typically functions that
> check some condition), so it's the conditions are structured as:
> 
> 	if (error)
> 		handle();
> 

  Sure. I'll fix it.


>>    */
>> -static blk_status_t wait_dev_flush(struct btrfs_device *device)
>> +static bool wait_dev_flush(struct btrfs_device *device)
>>   {
>>   	struct bio *bio = &device->flush_bio;
>>   
>>   	if (!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state))
>> -		return BLK_STS_OK;
>> +		return true;
> 
> This should be 'false'
Thanks.

>>   
>>   	clear_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state);
>>   	wait_for_completion_io(&device->flush_wait);
>> @@ -4116,9 +4117,10 @@ static blk_status_t wait_dev_flush(struct btrfs_device *device)
>>   	if (bio->bi_status) {
>>   		device->last_flush_error = bio->bi_status;
>>   		btrfs_dev_stat_inc_and_print(device, BTRFS_DEV_STAT_FLUSH_ERRS);
>> +		return false;
>>   	}
>>   
>> -	return bio->bi_status;
>> +	return true;
>>   }
