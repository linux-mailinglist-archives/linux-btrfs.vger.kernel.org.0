Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F9C4C60BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 03:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiB1CCl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 21:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiB1CCj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 21:02:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AC945529
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 18:02:01 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RLkdfR008190;
        Mon, 28 Feb 2022 02:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Ugh/ZkBWsh3gi5Akp21kXv2wTDl3GRpm9DhD9Wxlhb0=;
 b=Jc6qCmjLoxu3y1dbcpngFAxGhyWnlusVJUT0nEgUd7o4Kqr+dSFvZSzWWOQ9ZNQUCDTw
 huZVrzFWvE6QmdXBn5JOd3lCPxDJDM0E5na5IB35uCRUQ6nn5xI6QIBBtXGs5g0YvYmu
 hqfOpV2ZgosK95MF1/nU/Er03QWfkMoY422EgymJ+6bRK+yjb96gXl/uKXypffUd/Ya0
 je7OfWHnWkEdToVfjeMa7NZU5p3lBhOusPbgYBuXUi3GrSPiK2RxMmdcDac8V2rZAX2J
 398xf8NvVtM+m1LZ08wAa5SLuNv2X/jkgjBcpwaah4D+RjRUOs0tl++TQVEsnZ2SXh9p mQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efb02jwjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:01:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S1tvEA145583;
        Mon, 28 Feb 2022 02:01:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3030.oracle.com with ESMTP id 3ef9auphyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 02:01:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbuBwUTv9XOa3CzH8DaLBCmt0eUue8Du2SXvRKHZIlMnxCy7KKeOxRIcpqtIsdLuZTVTdZdjyo+KpyaXgbOnm2Z8kBXB+Hmb67Rqnj+nydesDJk1pIXyMKCRpT5CLY1169+j0WqqjyNGTPLwxRDvVkwB05wzU5CZH4UzwGVyAukw7w5MyfyrW+mrm07PhvO6xvdwvv9H9KrBUzirMxnpnMceW+BiY95UGZ6xEQgIAIBNjSITUfE4tlXzU1WrkLGsZsJLqQob0jj5o/Z9cSjD8DSnT564ySU/nKZM1zIRaJiAsGny3WzZFHnvyxhpPNUvmp6IZLuOk2GNSy3UTfo6tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ugh/ZkBWsh3gi5Akp21kXv2wTDl3GRpm9DhD9Wxlhb0=;
 b=WTtGypPMfIspcHly5Hce2MiTCFwR7jk7DcDbJlEpddqrBH8+De3dFRHZhzbuHQPBcK3xq9coGIav/hogSrivTxmypzIc6BMQoWjxKkBA66O4WSFgCJ52hmpm0FgqI7+x/Zh314tl8GcbiIxiV+SgwLGDlXGhs+7qxOzHCSh0V5LhWo68rrEe0fwnlrt36cJheyBk98Q344cpHYWTkw3vl3RH/KUuvuS85W9uCmyfuswEMAjJjiwTlTD7cz728C3DkYs6cKeEx5WtfB67SajcjC78V9gpgVdHRkwiNXfxMNbbeJEQm0LHap7pVNPB153BOjmsph/rhmWgjh3LPwpGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ugh/ZkBWsh3gi5Akp21kXv2wTDl3GRpm9DhD9Wxlhb0=;
 b=pctAF7MjLD4xWwpuPM2oAjBP4b1Tg9yeDZqSvt3yXq7z/lEoWAzNZlWVlAnVW7gBilR1Da2kWYnCQN6v8YIXJBxJ/3rVZ/K95jVbgh3St999AN01Ndg6I/9TCtGKvRpLGUfCa/nxFyEC7niTMoRY2v/NwIkKTFchMK89TL0m9B4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB3890.namprd10.prod.outlook.com (2603:10b6:a03:1f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 02:01:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 02:01:48 +0000
Message-ID: <43aea7a1-7b4b-8285-020b-7747a29dc9a6@oracle.com>
Date:   Mon, 28 Feb 2022 10:01:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Seed device is broken, again.
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
References: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com>
 <20220225114729.GE12643@twin.jikos.cz>
 <56a6fe34-7556-c6c3-68da-f3ada22bd5ba@gmx.com>
 <YhkrfyzmCgOGG+5n@relinquished.localdomain>
 <f4525052-8938-42f9-543d-c333200353dd@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f4525052-8938-42f9-543d-c333200353dd@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dedd27fd-d0ee-47dd-17c9-08d9fa5e4738
X-MS-TrafficTypeDiagnostic: BY5PR10MB3890:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB38903C55C341C780C495340DE5019@BY5PR10MB3890.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bDLrcfzdvCJuq9vshk803U9glkumAUQp5KRpKUwiPq+dNDOBLD05Cv5oUuIv3yVlYUZQy/WPc6hRFlnFQob7YL9ymFtqLur5/3+nY+Xz444CCwp5CRR39+u+rMrHuUiHsV2YleQwd0PTRNQTy0ziDLHyf/3Ncf98xETy/WizdJDrFyruRWzst1ZF7XZO/5z4QPe8RsiyM4Ag4tIdgq8a2rqVe3fpMYXHaW65UHBkq4LxxfNyuZ28Gr/TD/Nulb1Mxvba5e+CHY6mGdoNJuJ1Iu18AGXN6Bd/LrtmBqa5m/glXBR4Q6bUtuNkNTLvmoJVmH3whKmCM8GvV+Wh0BWB0unH7TOUSW85OZnuloEsuSuYQ5iNOJtaGHhmA9uso9F0OqFGzB0cg3uF6JZMcW6N4xP2FEzcp+PxYS/BWXK1wy2LGLWYrN0so7bQZHz7m1Klb53MsG6O4KtGjKyzLKhrHDoSLgH4MQ3WbJYHnOYcfQcS3i4K3tUaMCVNyrkoP61gZFaFAlcQGTLbSFpvdOIXrV8q5EGgbFXa5zHJMFZfT6KoGoCLCrpIqFiI6LFOi4sUhNgr1DI+buWjTlSF8e2IdvN4Y2RCifR171l3MYd/EWMykzfVhPJltj6nIhfX19kvlNzbC9Z4aCT0Uy820ePxfPmpYEKXpRw33xJowdnRTL4M5Pdv9PlfkNX2kYtP0BHQxS3NQuDQtmkv3Db5sIMlnlh+59nItPJgSH1SmNzymA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(186003)(2616005)(508600001)(6486002)(6666004)(38100700002)(6506007)(66946007)(83380400001)(31696002)(86362001)(53546011)(110136005)(54906003)(5660300002)(2906002)(8936002)(36756003)(44832011)(316002)(31686004)(66556008)(8676002)(4326008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akQyeEZzc1Y3emt5Wkoxa1lucjh4VEdtUUZlaUh2VjlHelRuVSs1S1pWUFN3?=
 =?utf-8?B?UXJOU1NXRmYxWVFMTTRzNmtZaVFFNk1rUDMrU0JGZEdJSmxWWDRBaXpDTXJs?=
 =?utf-8?B?N3JtSDlqZThHbTYwZTRQSUpaVDJValRXeVJMbFkwK1AzRGkrNmFqYVlpVm5m?=
 =?utf-8?B?OEtMQm1EcFRhM2JWd1E0eHVTK2dURzY2TFcyYUJsWVRWODBlZVQxVkpJTS82?=
 =?utf-8?B?aUhCSEpKOUY0di9sR0RvaFNyUHYyOVJnbVRCTGtkMUVaZWZsQmF2ajQyaC9v?=
 =?utf-8?B?UExNVkdTTE9ONEo3WVNxbWpEMGcxN0RONzhBYXVKMEZVbG5uQVhIUVJqQnVS?=
 =?utf-8?B?TndGZUx0bi82NURNYVlsTi92Q1hnOFNJcU1zMnVHUWlBWG9DMTFVbk5jQXZH?=
 =?utf-8?B?cjB1b3lIQVlMdTMxMDdrYlZXUjFjbXVJZU5PZHJnSFNmSXZMYk1IUnU3R1hF?=
 =?utf-8?B?MWM1RzhmNlhsbERjWTlBczZrdTBkUmNUc2Fwa29QL3h5bmxzVnNhUng5R0pJ?=
 =?utf-8?B?M3VjZzBNM2ErcmNHQzE4TFVra2tLcG1wcmRJSlhuL0EzaVgzZ3EyWWtHMHRi?=
 =?utf-8?B?MW12VE1IRUxkNWdjcmFUZHA1QmRiV2VIOWhzUkNodXRBUnM3TlJFNmErT3RL?=
 =?utf-8?B?Q1RYL1JHRFRrVGZyTFVzT0I2T29QWk1PMldjTEFYUHI5TExYb3JlWFZKYmRo?=
 =?utf-8?B?b1Z6Slk3THMzdE9YbnByTlpzTHVrbzBud2lCdkQxYUFEMTBXNnFqRUFzRURy?=
 =?utf-8?B?c2hjcFVnUVZnSmFuUEFtcTJ1dmJMcnpKUGhUU2RmY2p0MFpBUWROajMwZWgx?=
 =?utf-8?B?d1hhdmRBZ2hPS2FKSTQvLy9BL3FNenlPR1l2UDdwNC9iRG9sajFrUS9YV21F?=
 =?utf-8?B?Z1BCNksxcHliQ2FvckVlLzBxenkzTmJvNGJtaXlMZUMyT3l1OVlrTVZNWGlj?=
 =?utf-8?B?cGsvamd6bGc4S1djQ2ZoK1dZb3NoTjN2VTBCdHhONUVJeGhGUExUcG80U0Yz?=
 =?utf-8?B?ZVVtRGVYRndPNkpiRnlWZmM0Q1ZBQndIWDd6YTBkOWkzODF2TlZUeFEzaWh4?=
 =?utf-8?B?YVBuYjR1aUJxUmFzSVNwZ1VXWjJ1UHMzeWQzZkd0RmlqdHkvSENzZnpMNXlD?=
 =?utf-8?B?MnRXMHVUZnN3d0M5QVJ3aW9IVlZBd0s0YTVyTVIwSzI4REhGeUlDWGZ3RXdM?=
 =?utf-8?B?NzEySWZKNGY4U1JaU2RWdG9vRHVzaGtYZENmUjhxT0lhK2ZJOHJEbXArb3dO?=
 =?utf-8?B?aEVpZllCdkcwNDZmQy9CdVNpTVhIdnNUbS9NenlOb1V0VUh4VGtzVkcvZE41?=
 =?utf-8?B?bm1HK1d5azhtVGNtdlY1WGVub1BtNzZQVXZIYzBsRzBscWo2SXp3alhuMmh5?=
 =?utf-8?B?UnVVQWRxQ3BRZnYwdGc0eEFMSEp1UGEwUTVWWnBhbFUwd2g2RTdNcnAvS1pk?=
 =?utf-8?B?d2RnaER6OGRLT1Q5cUdodlhoSmxZeUdsNkxrRi8rRmFBSmhKQlFBc0hPRHRm?=
 =?utf-8?B?cFN1VTB3UjRBUnN5ajk0MnpielN5RUZpUnpLb3M5VEdzY0lDK0RYdUEyNVYv?=
 =?utf-8?B?Nm02SWE2Tk9MUzNVSm5qbkNXRWV1SkRJWUJZMVkvUWYwajByTTA4dnVKQ1U3?=
 =?utf-8?B?Q1l0b3NlZHJTemhGYUpWMDE1c2NxLzlkSk9DOERUU1dWYVR4ZktxM0RSYm84?=
 =?utf-8?B?MVplTVVEYzNoVGJpblJkeTRQUXRqVGpWVk5jRGJIYWNDOThGeGhib2ZvU0tm?=
 =?utf-8?B?cy9NN2xENWI5S2ZvYWVJSU5ETW5yWVVQTnpSTHJSZ3pIYkR0eW9rM3BsM3Ux?=
 =?utf-8?B?YXRPZXdOMFN0QTBrWUdzMEpCekRvZ1lpSmNobTNJVUVwTXdKSm5pcG1zMkpQ?=
 =?utf-8?B?anhpOEFDNFNScUNKNjB4TWxlWE1iWmdhL2s2c0o0cE5sQVRuSTU2OUVMS0da?=
 =?utf-8?B?L2ZaVTd1aXBaUHZ5RHJZRCtxYTRoVTNyNDZaNnFvSnk3VGYzU2ljK2NVam9Z?=
 =?utf-8?B?bXJOM1BUaGJ4aTJUK0d2bWVKdUtxSzNUcEoxeFFUV1drdVA5MlhWYlIzaXlE?=
 =?utf-8?B?cWV0WFJvd2U4RXZhck82anNjT1V1T1QxUTZYUzBLZjhMazZaT2RTTFJ3eTlh?=
 =?utf-8?B?eWlCSzNKYUsyUGUrV29hT2N5VEdWVEtuVFZpTVE5RFdZbUh3SVpzUmR3cDdG?=
 =?utf-8?Q?UeuqX6hey/Xkubh//kTCu8o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedd27fd-d0ee-47dd-17c9-08d9fa5e4738
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:01:48.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7aM/GGGDq5vm56O0Yn7uw2WBuF6Pf8w5zsMks71MjJ+nW0bEd+aePzDPoSqaBY8RkjwoFo/2Iv8bi+P77E5GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3890
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280010
X-Proofpoint-GUID: 0txKSmOcpGX1kOocg7diOievztdO_PTT
X-Proofpoint-ORIG-GUID: 0txKSmOcpGX1kOocg7diOievztdO_PTT
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/02/2022 07:56, Qu Wenruo wrote:
> 
> 
> On 2022/2/26 03:18, Omar Sandoval wrote:
>> On Fri, Feb 25, 2022 at 09:36:32PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/2/25 19:47, David Sterba wrote:
>>>> On Fri, Feb 25, 2022 at 06:08:20PM +0800, Qu Wenruo wrote:
>>>>> Hi,
>>>>>
>>>>> The very basic seed device usage is broken again:
>>>>>
>>>>>     mkfs.btrfs -f $dev1 > /dev/null
>>>>>     btrfstune -S 1 $dev1
>>>>>     mount $dev1 $mnt
>>>>>     btrfs dev add $dev2 $mnt
>>>>>     umount $mnt
>>>>>
>>>>>
>>>>> I'm not sure how many guys are really using seed device.
>>>>>
>>>>> But I see a lot of weird operations, like calling a definite write
>>>>> operation (device add) on a RO mounted fs.
>>>>
>>>> That's how the seeding device works, in what way would you want to do
>>>> the ro->rw change?
>>>
>>> In progs-only, so that in kernel we can make dev add ioctl as a real RW
>>> operation, not adding an exception for dev add.
>>>
>>>>
>>>>> Can we make at least the seed sprouting part into btrfs-progs instead?
>>>>
>>>> How? What do you mean? This is an in kernel operation that is done on a
>>>> mounted filesystem, progs can't do that.
>>>
>>> Why not?
>>>
>>> Progs has the same ability to read-write the fs, I see no reason why we
>>> shouldn't do it in user space.
>>>
>>> We're just adding a device, update related trees (which will only be
>>> written to the new device). I see no special reason why it can't be done
>>> in user space.
>>>
>>> Furthermore, the ability to add device in user space can be a good
>>> safenet for some ENOSPC space.
>>>
>>>>
>>>>> And can seed device even support the upcoming extent-tree-v2?
>>>>
>>>> I should, it operates on the device level.
>>>>
>>>>> Personally speaking I prefer to mark seed device deprecated 
>>>>> completely.
>>>>
>>>> If we did that with every feature some developer does not like we'd 
>>>> have
>>>> nothing left you know. Seeding is a documented usecase, as long as it
>>>> works it's fine to have it available.
>>>
>>> A documented usecase doesn't mean it can't be deprecated.
>>>
>>> Furthermore, a documented use case doesn't validate the use case itself.
>>>
>>> So, please tell me when did you use seed device last time?
>>> Or anyone in the mail list, please tell me some real world usecase for
>>> seed devices.
>>>
>>> I did remember some planned use case like a way to use seed device as a
>>> VM/container template, but no, it doesn't get much attention.
>>>
>>>
>>> I'm not asking for deprecate the feature just because I don't like it.
>>>
>>> This feature is asking for too many exceptions, from the extra
>>> fs_devices hack (we have in fact two fs_devices, one for rw devices, one
>>> for seed only), to the dev add ioctl.
>>>
>>> But the little benefit is not really worthy for the cost.
>>
>> We use seed devices in production. The use case is for servers where we
>> don't want to persist any sensitive data. The seed device contains a
>> basic boot environment, then we sprout it with a dm-crypt device and
>> throw away the encryption key. This ensures that nothing sensitive can
>> ever be recovered. We previously did this with overlayfs, but seed
>> devices ended up working better for reasons I don't remember.
>>
>> Davide Cavalca also told me that "Fedora is also interested in
>> leveraging seed devices down the road. e.g. doing seed/sprout for cloud
>> provisioning, and using seed devices for OEM factory recovery on
>> laptops."
>>
>> There are definitely hacks we need to fix for seed devices, but there
>> are valid use cases and we can't just deprecate it.
> 
> OK, then it looks we need to keep the feature.
> 
> Then would you mind to share your preference between things like:
> 
> a) The current way
>     mkfs + btrfstune + mount + dev add

   And further, dev-remove seed if needed.

> b) All user space way
>     mkfs /dev/seed
>     btrfstune -S 1 /dev/seed
>     mkfs -S /dev/seed /dev/new
>     (using seed device as seed, and sprout to the new device)

  Does the -S option copy all blocks here?
  How does it work if /dev/new needed to be an independent filesystem
  only at some later point? Add another btrfstune option?

> With method b, at least we can make dev add ioctl to be completely RW in
> the long run.

  Could you please add more clarity here? Very confusing.

Thanks, Anand

> Thanks,
> Qu

