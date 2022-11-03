Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB590617FA8
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 15:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKCOfE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiKCOfC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 10:35:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A24E0E1
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 07:35:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3ET2ba032637;
        Thu, 3 Nov 2022 14:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zzaorvfNpiV3VtpDm/WBE4408yxGcPcLHxQfgm/GUx8=;
 b=mtluyyu/AqwVf1cYA8CVh23O1R4+yq017lvV75FtT4k13eL84o1xVO+7aWNSW6MUQ2pa
 CTQxd/jy5bgWn0zYBz9+hJ6xDdie1Pr/l66tyv3r8A19gj/dw7n/QIDJnZdLlK8WHtAw
 g2vJrhvkhKN3EdX/knT0ukcHKOn5z63KAdCvto7HRiuGeQ2KgsTVxJ2hdoGAltDNenR5
 W4NL2sSsf9va5QN4z2f15i1FMUajHLVZoiSI0WTt/HdPhrkGl6azVhOm3Qz5S11+opHJ
 oKFvZajU4PIHxJACpzGJww/ql6O8z3Xaicm077SOYmPemnX0ozv71Gt0OmoV092E2ZbD hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2amvbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 14:34:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3ETXge035748;
        Thu, 3 Nov 2022 14:34:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmcs4hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 14:34:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJam8HukiBH0XTVDMWkkjuCFpX/CFvzuuzR3hOq4CbY+tbqwgGsHDv6Zc6MIzF+WqnDos0BGqZHjdxkJcPlgtXXSd9YEk6vBDPG67BJduDc6JDAsuQEWMLHonD3Bbg/RzKv2+qGKlOzSeKUjY4Uw3MnOpY56Y3GsrAqiHeonhScwugQmznqYEzJIoMmojA4DI0CD36gcNq/t4KkPAIqqLisPDKE5glagQW+LALWpWFHHCr377UOS3j6u7aXoYPZqadXRWbl9Px5AUzcaj/2BSi6zX7MEQWo/+rCvJYmNfS2anign2942ps4ep6H3ZGjQ5mWB74iJlt3075ekdhD7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzaorvfNpiV3VtpDm/WBE4408yxGcPcLHxQfgm/GUx8=;
 b=c6QRYfTcM3Gul0KG3VXcjm6iyreSdBaSJMNAmB4NxuhhV5EouDKDeax3poayUoDnrVqbQq3cD+ntzV5+NQzbJBQ75Ng4zPcHf4zA0x0Pc3oOuNwIlykQjhEcTts9B4xFmjXISYDJDnOd9nuyZrWYhzL8kiTWXw4GXP5v/XJ5ltK/ez9F0mBlu/PQeuKOIzZJFFUyv8+OPFUH34ucMC5E+65kr4U0EsmxyIukCpVFjtctgyLMTi19IIbUK0vSg4UMtstBAZV7a7xlOquOXX9f2aWQq3J1H3efJ7Kk86qTvzGz0yhJ3LutJ+W1yQM11Hy/4GOKVySGpkZmIT7u1Ta2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzaorvfNpiV3VtpDm/WBE4408yxGcPcLHxQfgm/GUx8=;
 b=EYck7oMxXHLyGfe7MNoNKl4n/JSZFvqW/aV5dwzWh2YOlywc7jVvA4fU4BAZlC9rN8mYTAJd0p5FjaytRjCSdYlFrhwKMaaZWx3AsXTS54iaUQ51GZh87DkAuq970MZseEIZwoQOQNHG62hp+AuhHQnHqRTdq3o18ov73HBiieY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6302.namprd10.prod.outlook.com (2603:10b6:a03:44e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 14:34:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56%4]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 14:34:51 +0000
Message-ID: <8acff1ce-eec9-438e-0f13-f8c84ed72b8b@oracle.com>
Date:   Thu, 3 Nov 2022 22:34:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 04/40] btrfs: simplify btree_submit_bio_start and
 btrfs_submit_bio_start parameters
To:     dsterba@suse.cz
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1667331828.git.dsterba@suse.com>
 <5f4b7a11669006529515316bececcddbdf513534.1667331828.git.dsterba@suse.com>
 <97d1de75-62ec-dcf8-2d0d-e783a07a24fd@oracle.com>
 <20221103132841.GN5824@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221103132841.GN5824@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: a9bb90dc-0d43-4c07-8bd8-08dabda890bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/S0BWPmZDE8lktTM1Ym6M0K+sgwIZVuWUdIjFQmNYY6BYNCJvRLQi9QPVpJKAjQqmxyoKuP8OuYx0HBtegA+mLtgUaK5l023wBM/R+5+021xVNzPaGY9XOUN01n4facaggdCOf9aH9MK4IBTg1gfysOZHgbueXsaViF5CmmSEngU6c8VvTR/eeAAS4t8l5GJnBgJPl953mEfeJJ9WyAONQ8TIKbUgglxAASY3MlAiF7LWtwYeSIx+/vxcFz8p2UgZJiWG3qKzo0+8btsS0d9sEBI71KHhU8B/InbUt4lzAzSoS6Nn8Uoqx42+u1uoETydrPd9VEwF5U2akA6wzsuZZyryRTzkThJc5UBariXtENbVhYZgYV/N6twYDixUURGsperRWrlczzeNbPZff0L/lzA1kCm/EhxI0VTkA0Yqo5+eWL9gXmmKF8zVRnEcI+0FPSiafOjxJ2ML1kRZ0PKwexD4iSDqxkOVhEZGyVSvty0hcN90Oq4Uuk3GQN5KojG4jsfYvGg4JahQASPqIrX0LLW9t86OCro7jiJcX+eck0m4ZmncZ+zI7LQUN0c4WDWAv32RsXxgbAH9ZTcEz3ZRwQeM1Au/9zRSA7W0oWpObTfwDBftxPl5YB83uu19cStzR1njeRSoQtItAwSNUG7cxpJYkRX0O3ww2yZjeu5iknI05agJnNzqXcBchkenOot3CQkY2/htLEzcGRiSXvFi92vP7hf2Gdvytm6pPQiF3rMWwDbxhxmLAC+BkzlZO+kvjVaXlSHSPWUBy9lw55xj0ZI32UWWkXoDepN5liJOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(36756003)(31686004)(31696002)(4744005)(5660300002)(44832011)(2906002)(38100700002)(86362001)(83380400001)(6512007)(6666004)(186003)(2616005)(26005)(478600001)(6486002)(316002)(6916009)(53546011)(66946007)(8936002)(41300700001)(4326008)(66556008)(8676002)(66476007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRvLzl5bjk2akRpcDRXcDV3bndkZ3h4WThLNjdhL1BJdjRWSVVZZk9ZRm1j?=
 =?utf-8?B?N2ZjN1JyL3k4alpHWDJUelkzSVEvcjlTRWVuc2xvTDByQjZhSmoranl0T1pq?=
 =?utf-8?B?bzhxU0FxaC91VitUT1BHZW9uY0h2OTNHdFlnc05QQkY2Yzh5ZGdPMWpBQm9n?=
 =?utf-8?B?aStUWkN2TmlIVzI0ZGxMYkZ0aEtRd1FURklqTGVIRG5OTTN6UjVFdCs4NUlk?=
 =?utf-8?B?VENYUEFQK0VCVzJ3d2tsYjFnMTZtcU03MzdudGpoOFVweEVobXh3dTk2VWUx?=
 =?utf-8?B?UDg0R0ZmTkkvTit6Y0VaOWdBZzMrdGM3eVpVRndoSXhoSENraUdlZTNXMTZv?=
 =?utf-8?B?ajZJRk5HSjN1RStqcFFRSVdXUXgrTzRYcVdRbytKWlROdnFyenQwWTY0Y1ox?=
 =?utf-8?B?aWV3SkRtU2pvZWVNQS93UmZ6dDJZNGdTeHQ3d2YzdGJGU05FeGdTUWQySytC?=
 =?utf-8?B?Sy9QaXFMZG9lcHdhTEtvVjhtS2pDU0o0R1ZKMVl3Q3NMTFhaMWErTU9mWDVD?=
 =?utf-8?B?T1YyOWxBR3ZrZExwWm9mV3ZEbURuUElKWEIwWEMwYm92akFVU1pXTlNnVWFu?=
 =?utf-8?B?eWhmaXRRbEFjeVlaK1hleS9OYmwvaWtka2hybTF1M3ZxYmdWc3M5TTkxSnZs?=
 =?utf-8?B?c1hENlhKMzdnUnFNakZmZU90eWZ6cHVhVWxlRXpPOHdGclZRWDRNOGtiZzRj?=
 =?utf-8?B?SGVBQytDSmx6THRHUkNISVBNdlZZWXFERmN5VHhWMzk4cXZiaDhIZUdpMUx5?=
 =?utf-8?B?dkpGOWIraEoyUHZOaDdrR2FaSFpUWjNhRmVzelJWRElXMkpMVVNGUDB3UDFX?=
 =?utf-8?B?TkRKY0M4d1daU2podVdUcytHTzY2cG1jNlY1VWFLQkhvaTFmVGxEMVNEei9k?=
 =?utf-8?B?a2ZWeVFaQW1tVExJN1RTVkMxWmJTb01Cb3daRnh1d0JsbmxsWVlIZG1mOW5u?=
 =?utf-8?B?UVFBWVNScmtDYXFDK1F2Q0duUHFQODZNOXArVXBoTUtCQ2lkdVViVEhZSDZj?=
 =?utf-8?B?R2VoZlRSejZld25LUlNjeW1DZDJWNjRTblFYbFY5U3B4ak9oY2lwb3NGam1u?=
 =?utf-8?B?L3pzYXIrVmZIV1QyVlkxQ3dRbmNuUUtjcTNQdGdIZGNzd1Z0TjNtQzdiL1Uz?=
 =?utf-8?B?cTBUUGlLclBRNXRMR3lESGRuRVo3QnNVK3ZZYjZ6WWFDWlFRZmoxRkkzd0Va?=
 =?utf-8?B?RURHVDY4QUoyVE9wWFlmQURtNWU5YU0wL2hKazZqcWV6cGVJbXoramxMcTk3?=
 =?utf-8?B?Wm9QeXZTdHVJUFcxNEUvYldocEUyVmhZdStlZXVScG13YTZxdWcwMHRDQ1Br?=
 =?utf-8?B?QWNha21WM0ZuTEdYU1JLMThJdzMrZW1PbmhVVGRvV09PYkVmSlNEWmF3OWtY?=
 =?utf-8?B?Z2xvNkoxYUhSWWNjbmdBMzhzN0YzVnAvQld1VDRSSlgwYkFFTWVYbk9CT2px?=
 =?utf-8?B?REIxOSt5TXdLd3VTVmFxV2dIWDVrTmtrY3JpOFF4MEpYaVlDRjlvWFZ0V0FG?=
 =?utf-8?B?VFlXUThGaHhjREZSSWZpNzc1a01PU2JVOGF6MURPNGFBdTI1NnMzb0EvaExh?=
 =?utf-8?B?Q3MxelEvdStBb24rdjZDcEhyMVA0V0FkMWhtNkppKzRWSWdFY0NCWEdoWll6?=
 =?utf-8?B?VTArVEJqOXltb0p3cnlIODhlVkdFWkM1ancrNzF2Qm1XUXBLQU9kcXJSek1l?=
 =?utf-8?B?WlBlZ3JmT0k4aDVEc0Q4bmhNTGpmT002c2FpQ1l5dTdjNzIvbmxzbXB5T1Nm?=
 =?utf-8?B?RFlZLzVCMXYvRExwaXlkaGdoS0RkMXZJSy9zVlRBNStJcVdxV2xSZWxzbWdU?=
 =?utf-8?B?T01meVczazJoalpXVXRvUXVMRlNHU2UzYlhUUVc5Y1FXU0ZqSDhBbWplN1Fx?=
 =?utf-8?B?ZVRpZ0ZJcVJGVndrakFkWXdjWXg2OUJXcWZ6U2t2dVR2REFML3BWenlNTUJW?=
 =?utf-8?B?dTM1OTNXNHVjY2p5S2EyRm5VQmF5SHZBK1REMlFaMm95VWdBbUdwK2RpcVpD?=
 =?utf-8?B?RWdrRVh2WTRMcStHT2xsRDFzc1ZqZjdZNU1uTzBXVWJaMjh2ZTR5UWYzWTdN?=
 =?utf-8?B?VDlEWXdLRFpld1ZOaHpwbUxTYldnQ2dyQW80LzBMVXBjcHZqbjU3K2c1eEgy?=
 =?utf-8?Q?Cr4y150/CAiW0hPyp3rP2DadT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bb90dc-0d43-4c07-8bd8-08dabda890bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 14:34:50.9811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVd4/KXg4f1VTGuCwROZz03R6DAPa2tP1M9XjDjr4UYzS2Xju/ddG5KS2FhszsiUJlmRJwsK1GtfafEpZyKAtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=985 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030098
X-Proofpoint-ORIG-GUID: WtuN9HCMAmJ2YTv7Sk9zO2Z97F5auGOy
X-Proofpoint-GUID: WtuN9HCMAmJ2YTv7Sk9zO2Z97F5auGOy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/11/2022 21:28, David Sterba wrote:
> On Wed, Nov 02, 2022 at 08:12:06AM +0800, Anand Jain wrote:
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index 962e39b4f7cb..2a61b610e02b 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -2550,8 +2550,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
>>>     * At IO completion time the cums attached on the ordered extent record
>>>     * are inserted into the btree
>>>     */
>>> -blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
>>> -				    u64 dio_file_offset)
>>
>>> +blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio);
>>    Remove the semicolon at the end of the function declaration.
> 
> Right, thanks. It gets removed in the next patch so the whole series
> compiles,


> I don't think it needs to be resent.

  Yes, of course, no resend is required. I am fine.
