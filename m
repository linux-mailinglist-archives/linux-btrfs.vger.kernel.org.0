Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78307AF1AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 19:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjIZRT0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 13:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjIZRTY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 13:19:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B1D194
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 10:19:17 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QFhuGx022206;
        Tue, 26 Sep 2023 10:19:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=phJdFO7/52pmjw9Fdz5GTYaOqx0venuD/WGrQcpo+sg=;
 b=LVpR7Vhx1aoTIKmhlD/sjA3QEOH1j/jTTFDq8teV3DuAnsCaI0QzdCN+SttOVJftAtxj
 uSgzY7e/5R+z51Iac++k2wMCA3GXbQdRX0ACAvMxi4y8d2PSmg5VTs7qlA9TWlBZUzS+
 0RtWuWTA/9uY/OxX2DsQOAkZ9mUY4meROysF/iCBGqoqX4cpCB/rXmvyX/jMh/jOttqp
 On7wfKdFAgUyB+b4dbpIYvdubYxPLwZtoGqlWyLaLB3pic2cvi/3y1Y4Oq8ealUjEUXi
 vb3rv8tK0t93cT70TisEG2kTA8WGmUpu2RTK/P8Twy9XwDXSfRNQRbLBoAaHmNVwuxo+ Sw== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tc10ej3d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 10:19:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMGg+ispwO6YmNEJ6NZnrUjEAKm2zM4Nn4qN0N3zYBQnZaZPHTYZWWsmu948UsHVAXvzMabFXIpfb0jjxrUFCtKEmRvHB7EzyNQ3rKh61p85tg+iBDX38zVXFZxB7vXYF5jdgs1W8w97mdQ7oGhLUET+yBMj98syWpTyMF7aUX9c99g3prTKpPXajI3C5hpOYVIf0uCGaAeWg9Fq7zAn+Sf3Uo/jXgiJV3E8XkVUgUinduxrc6U+cFEu73aSIwS8HSGRC1P7N2zvD0NcOYBHwYBeEbaXHvFiLOcbtKD2TzN0QoNwJDgnOHOu6dRXnKp1NUYPN/qIe1u3g2/PRbnaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phJdFO7/52pmjw9Fdz5GTYaOqx0venuD/WGrQcpo+sg=;
 b=IwQnY9f0zQphPJDIKNvljQOs+bNQoOkEqLY3N4uKem1L20i1QHW5RU7JCkrHDp3Vdq1jUJMon4+bNxhZ/bsUlxF1suYFvkniB353ry3db4h7JlGBj6x9AbsfRjvNlmSbJeAUcOLwvjb/x27wYazx+Yzd1Ypk1PDuXx03KW8YbXHsIJbjf7cSnhdEeU2WxOagYal60RbE+kpu6cb3n3NzLIMyg9q2s7VkCMueukupXK7kS8j+Kn21L21DTkOPwcU0JUmCv8zelEXjMsRq8+uOb8LCeWmAxrWfAg4xWEnpJzMfPKB+6pirM4kDqGrZNNTGoJR9owuVkvUbUDeXyJVyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by PH7PR15MB5474.namprd15.prod.outlook.com (2603:10b6:510:1f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 26 Sep
 2023 17:19:00 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::729a:d6cd:8a66:8983]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::729a:d6cd:8a66:8983%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 17:19:00 +0000
Message-ID: <9b98c3c1-2915-2a04-e27a-defb739832a0@meta.com>
Date:   Tue, 26 Sep 2023 13:18:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Wang Yugui <wangyugui@e16-tech.com>
References: <4108c514-77ff-a247-d6e1-2c12a5dea295@leemhuis.info>
 <706df63f-ec5b-457a-b0ab-2d18816e3911@leemhuis.info>
 <20230912072057.C1F5.409509F4@e16-tech.com>
 <34cbea07-8049-4089-a0cc-79d6c423c4f5@leemhuis.info>
 <6ba3e137-ba01-4f29-b0f2-bfc9afcffce8@leemhuis.info>
Content-Language: en-US
From:   Chris Mason <clm@meta.com>
In-Reply-To: <6ba3e137-ba01-4f29-b0f2-bfc9afcffce8@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::14) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|PH7PR15MB5474:EE_
X-MS-Office365-Filtering-Correlation-Id: dd73ec9a-3cb5-4194-b952-08dbbeb4ac72
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DB2rEwqjT5k0E+djbkr0jlkir+DVdDIoFDtihqSqUmI3WcanwIjnCAdYhCR6Q72LwaxarU1TedSA0SYuN90rm+SfBvABRHZ28CDnYyXT70auqwtDSKrH+CNCXPvS3o7DhMquroyTMNsglXAhioNt8JZYwtpxKgg5zJj9YYTfxTMMAn/jUNp1Orsgi32dqVWt89u9Xr5zYCrce9+OfazKvmrqKOOwDXrSUWXFJWpCJRNYPJvV+cOI3VHDRFT73WkN34kOV/fybAf+TJIQH1Zq3wFyobBVI/q6xmzm32HdCgPlAovPGbx82K0v6vi7FMae+EqBxK+O5kAPvr0Md4Y51LlLSgbQBxNuf3I5x6TilBXokQiFjrASvCH0lqoF3HHVaJOVdQEicDXQUFWAFqVOW+ViPqFmEyqmKP2bYa+sx+ljTMocGUOLJMJ4j3jLQ/0aOdVP+TWDnbOx3QE8RouaGUf2s5jZljqY5Udf20RLEfNGa8QzM7EsSO7hSdzLXPHrtJSL1xlVMkbZXVRS6g9JcAebrBA7z6/yUoZN4zL9WIV5eHwD5ubwbCneenSSYkxyYGVprc7nYYPUzXJguTbcgnzlk2z8vVM9lXbRWUerIBfYxwl35njhC+5KHlgvseJ0Z3PQZny1l+UzsAygnAZjzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(478600001)(83380400001)(38100700002)(31696002)(6506007)(4744005)(6486002)(36756003)(2616005)(6512007)(53546011)(6666004)(2906002)(86362001)(316002)(66946007)(66476007)(66556008)(4326008)(54906003)(41300700001)(110136005)(31686004)(8936002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUJHeUZhMDFaejBFVGM0czV1NkpETjY0ZGFRM1owbTRHMGp6NTZZbUxPT2Ez?=
 =?utf-8?B?QkJEL1BSQ01sbC9kamp4d0xqN3gzVzdlUWs1WExXYkJTZXRIZWNQWUxDNUFz?=
 =?utf-8?B?N1h1dWhuN0liYU5xb0w3WVFCdGNKNlA3M1c2ZTVsWEY0TkNKUGFsdVkyQnVJ?=
 =?utf-8?B?bFhYdSs5eXNoSm5DdXlHQjVWQVJHaUxVazNVZkh4MWRKVm1VRER0VERRUHVq?=
 =?utf-8?B?d29EQnkxd3ZOR0VyM2lkb25vSzdUZ0c2YThQRkcva0Z1U0RYcnVmQVYxTEVE?=
 =?utf-8?B?M1lYNjZDZS90dkZGSW1YOENTeFpBekJsYU9sVDQvY2lIamJtbno1NmVERjFP?=
 =?utf-8?B?SW95R3d6bElTL21YcTlXQjUyTVpCSS9HSW1GbFBnYm1LZmdLTms2QzZ0NVp4?=
 =?utf-8?B?aUJzdnltM29laWJvMGpQK28xVzgzTFZIMlF6TFJRVWJFYWhKUi9uYm84a3pG?=
 =?utf-8?B?bmdrR0NJYjFoNHBIMVNWRzh5ZnRIb0VBaU5Ebi9XbFB6M1pMVWlWY09UQmNF?=
 =?utf-8?B?UGtoam1SQkRmTlhJbzhyTEt5aWoxdUdibStkdGJyTjg2MlZGS2kvUUFIeHJx?=
 =?utf-8?B?b2NTbXNZakdSVkZEYlYvZFRSbS8vdWdQTWk0ZFNiejdpaUsrN0FQQzg1ckxt?=
 =?utf-8?B?T0JtcnhMNENDVFhrWGx6Ry96N084cEU4UG95aDlJT2hNazdKNXI1N01ONGk2?=
 =?utf-8?B?aURGTWVLdDNMeXNwQXhscTlTcmpZU0hGNUZLWkFEVzc1Z3ZCQUkvVWQ3NTlL?=
 =?utf-8?B?NVhMY1Jwd1pRZDhscnhzeHFiWVBwY1NiRjdHZVV2YjdWMG81VVQvSmZEeHlo?=
 =?utf-8?B?cnUzVzk4VmdUMkx2UVFLWi9pbUtMNElJV04xaWdBcDlmUzdRR0twTklyK3Zt?=
 =?utf-8?B?LzNPWml0aHZNYmpmbWR3WE9xOTByb3hrOXJQYUwvNUxWdm0wSTlHWmVNbjBJ?=
 =?utf-8?B?SmJEOEtDYmtTOS9XUlpNNU10d3laTFhTVDQva3Qxc1ZacnZYZHBrU2JWemZG?=
 =?utf-8?B?RVZsUlZuWHAwNWRxYTlVSGFFUUNuemJTWXFiWis3K0t3elI1SEh4bmd5S2Vj?=
 =?utf-8?B?RjFSWlhjQ1ZsSVdwcUVUR0djYWRFU2JVdzRHODMzcldCeXRoQ3JzaDhweGcy?=
 =?utf-8?B?cmhaMkpvNXI5ckE4VEdlVitjUUlKWW9wVzNJTkYrNUNtcHl6SWs1cGNab21z?=
 =?utf-8?B?aWdhRjBMZ09xZkxMMHhDL1JLc3JINjVrNmhIZVQ5UnMzRXg1MG1rL2czVS9D?=
 =?utf-8?B?dzJ5MkFCNFN0eVp3eFROVm5lOWc5aGY1K0FuM3BlRWpZdm5VQjFGV2V2SEtn?=
 =?utf-8?B?UGhLWFh3TFFvL3RpcTQ1ZW1JcDF3OEJSdG45YmFHQkY4bkNxMEtUNm5Hamtt?=
 =?utf-8?B?ZkJtNnk3ZjFpckl4TkdQdmszSWkzVlNOQURlSkJKbENuUFB4bC80WVR2VlVG?=
 =?utf-8?B?WmdzTlYrd29nQTExQWpLaUZFZEJWcjU4NVdLeUE3UnptVWE3U2xlQ2VOWHg1?=
 =?utf-8?B?NUVpQWRENTNrSFhKOHVTeWVHR3RLcEhBUW5FUEpIS2hxRitiaE1Pbnh2ZHMv?=
 =?utf-8?B?SzdmcS8reFRoUFA0elc5WXNXd1ZxRExsd1N1ZlpkQmxRQ2I3bDIwc2FObDhZ?=
 =?utf-8?B?dk0rcnlMTTF0TTVZRWVycXJlOVZRTFl6NTNBSEZQNlpHd3F3Q3lkeGxmVlVq?=
 =?utf-8?B?ekxpeXRocFJRRWx2dnJvc1dPUU1rbmdLYlJScGtqZU83eDZab3ZBbzRGOThr?=
 =?utf-8?B?K0xRNWRucVh6c0ExOU45NE85RmRVclVnU3UrSHpQZmpHZDlHN0JGbTBrUzRx?=
 =?utf-8?B?dGNlR25NYytEVFlKZjBwemhQMjY0dGpXUVVJdjlLaHhYL0x4SDRVZ21SN0lw?=
 =?utf-8?B?RkM3QVlUdnBod0dQUE9FMGRhb0luUGp2OWgrbGZNZjZHOUJEUlhmakEva3BL?=
 =?utf-8?B?T001eE1jNnEvN2tJVmtTaDBaM0dXRVFldkpTaDZ5Y3cwNEpnUE5rNUtDcnI3?=
 =?utf-8?B?amhsejNlUGJoMTVsMyt6NzJOeUREYTJ4Vk5OYklOMDl1ZXg5K0lGQnZnUjZw?=
 =?utf-8?B?WWI5K2wrOTd5R2NRZ1dWOVZLbWRXSmx2bUJvMzJTaXo5NFB4ZS9kcmNFNDBU?=
 =?utf-8?B?cGZ3S1d1aVF1R2t5V0VCSU1lcmVXY1NBMDRjbWI1NXhkUlc0V04rWXozVkNX?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd73ec9a-3cb5-4194-b952-08dbbeb4ac72
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 17:19:00.1512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVsLFIIwL+Oc2Gl3QEcqIcykEiuFIP4sFgrscuVW+TfqcBjoNU+I1wyx0vTZdEVD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5474
X-Proofpoint-ORIG-GUID: i-qIYgmZaL9XIVpnEN68RTmFZaeOVhRq
X-Proofpoint-GUID: i-qIYgmZaL9XIVpnEN68RTmFZaeOVhRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/26/23 6:55 AM, Thorsten Leemhuis wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Christoph, I'm sorry to annoy you, but things look stalled here: it
> seems the Btrfs developer don't care or simply have no idea what might
> be causing this. So how do we get this running again? Or was some
> progress made and I just missed it?

I've been trying to reproduce with the hardware I have on hand, but
unfortunately it all loves the change.  I'll take another pass.

-chris

