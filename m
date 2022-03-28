Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF6E4E930F
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 13:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbiC1LNj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 07:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiC1LNg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 07:13:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58295522C
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 04:11:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22SAXdnP032168;
        Mon, 28 Mar 2022 11:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eKdNdO2nTULjzl6ZR7l4k79+KrMGAcYdXKKGof7lXxg=;
 b=Hr0St8BwNH89rWqHpMmOBG/TMOjLn0WMGzSt9ZF2pRa5uxJcPR/XVsehEg3LGPO/+bA+
 VlaLtDtwPY+a4Xn5ZNH/bMxIrlaBJzpzjMCJdNpU+BRzMgXco+zbojwGCJEJmZPRF5if
 ICrD671Qj8me4rv76SU6WOdKp8ENsbeD1bBi5WdGkt31YDpDrb5dwLzkdNpsZXfdqQGc
 OZwOfdbzdCe9k7vXcNbBuf9zsmxK2OwqK5VD8X7g7J4r2rPD0BZFhVvN1cSTBeMs0duc
 6gB3WxkwYkNdnJrxrW39pokE9dv57d8WVTHr81d7K3YBDdJaGHmrbtoTi7J1udQ4nz/L 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1teru5sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 11:11:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22SBBnNc118520;
        Mon, 28 Mar 2022 11:11:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3020.oracle.com with ESMTP id 3f1v9fbp5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 11:11:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePAUUeEWfETEiP2Z710c3hVIRaQVnHQX3ztxzGWD7OF2LoQqMv0//a0TedyqpAjH4/g1irSbFwRJ4mDvCDC52gqavnb1IoaaomInQjlPkTFic88jcVOoUNL+rnTZGmrjobeQvQFL1t0pK92y5QbdCBVU3taMZoHGA8ysHgird4ImkJe55aLAyCH54UVwd327tub+4pN6v0ATp6O73on94IgzmUBmOt5Ci65Q8QQZELkm0I7i26/xSZjCu6E8CBJqwn9ZTkfPI7M06OW8TtXLnTlj0pVqwsGUUvNYv9GuWvgQx2xOhTPRMIgOHlG8AZ63r4kQLbpvUfGaH1piUa1YCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKdNdO2nTULjzl6ZR7l4k79+KrMGAcYdXKKGof7lXxg=;
 b=DzMLBVJZCGGo1Fa1ujgfqO2OKk4dqOV3dMQ1GvaNjJ6Tnosjn3ceqYP0mgvMXJIcRlXvYF/sFKYW7fMb7uzj5ZSkGRbeFQVZ2BVE9ShdyMWuYBXJoscly9uuEuhxyEKGM7x9/mIyRjBmM2mZMQrxm8MNnWDVW483EgmVJIRC9hjOX/RKSYbaEqUa+DuIHeVb3JtxeCD1I/GtfQOVyRk/Wp/1N8hkN2g6R6PoIbwZ0oInJSuhDLkaqeXh7F9p2EaePrKHpZ6sGeclIwhK8rEwUTG6fGzOEG1+DdoXwnwIaXw0SZvvA2Es7EDd6AQQGWaIn7GHyApDbqo6yN/42M2l5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKdNdO2nTULjzl6ZR7l4k79+KrMGAcYdXKKGof7lXxg=;
 b=ZfqUNmjSdLQvS3Gy4fexxEDgR/ceNZXfVpfvlDN9umnVnMfJ3YBup6cCgaeotq6Eux60277mjfXWEcD0Cc1AfEh4Qniy+Yz1MtRK7e8HkWGmbetrw+SFxiP9EJKUQlRMXfvE34tG4rdS4T7KOWbX0D8FWzhDh+rI9bgZrINuTA8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB3277.namprd10.prod.outlook.com (2603:10b6:208:124::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 11:11:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a1:3beb:af48:3867]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a1:3beb:af48:3867%5]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 11:11:46 +0000
Message-ID: <9770fbd0-e122-6892-4149-45bb6f988961@oracle.com>
Date:   Mon, 28 Mar 2022 19:11:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
To:     Boris Burkov <boris@bur.io>, Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
 <20220323005215.22qkdgherdyrocuq@naota-xeon> <YjtkE6DkhV0V0gXq@zen>
Content-Language: en-US
In-Reply-To: <YjtkE6DkhV0V0gXq@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 109d6e04-fcc2-482d-d0dd-08da10abbf42
X-MS-TrafficTypeDiagnostic: MN2PR10MB3277:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB32778FCCD66A2B1D1566EA14E51D9@MN2PR10MB3277.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8+xvBxtVbURznGIof4lhCiZI81B1GiMwyXh8F0BEYS98ktUSo1VDKN8WzTIZU6z6NSxwS628JSEMHY7Xmbqmc/yw7DD1G6tphLX5SVZAB8J69+4D0tE6+/ztZoNg1r0MMEapt6AvMhq0O7TB+lINsNaJAW3NkT448VcmcqZWG54yZnVRJiU8Ou2mP5mB1/1AlNnr1ofvHYEO3Z1trHgdEQ33NbBchFer4go8oZYBmI3R7N/UqMWdZT7/XuU66XNNcEfXoB6sAyAfV/8ybmMoKH2Aimm60reJZ1GvsT6Ie8TVOUNnAl4LySA9xGwBnuynWy52KX+1NbJgYLF6/3b5Fks/uNcE9sRKrCHG1LYy1QZ3o9UO6S0UVVgUyO2HQ6X3HHbeZiXUl9zhIpB820Ur9TGED/nuwkLjLmmy3g+Pl/uppFyJjAVggMjpUBMVu7IQQYUgzArosNzFS36kCFXb3ggWyT6gCWaxnPeOKzxRaeZWG2m65b3zGcNZSPFaFwuNt5nIc/+ssGVazXNw8XSoY5gw+L52xqh4ozD+HnOoO65N2Ctk2dgqI4/hXVy0IJkRI6dW4QlJ5z3viL7FL6CYa1G59D6H999XvXPQimHKGybxoJQz5EFd7z/ccg5HFbycT7TREPft+1n03gPmPJ6Nvo5TF0aDbc0WT3wW/TWtpVGJY6fSJrI/7yJcO4rhIRs+XC1GVPziVIDa3U9tPZ8TibI5p2GkG6yrmh65WcLeERHmaRfVelZEUmmirB8v/eGxZZ9ZIu7oA/NiNRrIC4ZyNaTykqf92DMSg6FMUfJ9YlYdtTg3BWfB4pgaueb+MIO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(6506007)(5660300002)(66556008)(8936002)(2906002)(4326008)(83380400001)(44832011)(53546011)(6666004)(6512007)(26005)(66476007)(66946007)(110136005)(186003)(31696002)(86362001)(38100700002)(6486002)(966005)(36756003)(508600001)(31686004)(8676002)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bCtVdEpuMklBQ0IvRXBRam1SaUJSZmxqYWpIeDVhcVY3bGNXdE5CS1hvdlU1?=
 =?utf-8?B?cXAyUnkvSVgwcWo3emg0VytuaUF5WjV6WUF5WS9zbnhUdlowT3FxVWhwL1Jn?=
 =?utf-8?B?dDFHeDl0VUR3M0RtU1J3VW01Z0h6M0Jpb01zNkV1NWp5YjYvdVduOU80cm9Z?=
 =?utf-8?B?TUlubWovUEN3MUc1S2JYVWJxOXAzbGtPd2ZZT2lES3ZtZ2liUGJuNUZseWpK?=
 =?utf-8?B?N3FqbFI2TThJRzFsS3V0UHAya0E0V0xoQzhlRzVzanpVbkk0Wi8rQUpOWWpu?=
 =?utf-8?B?RTEzNjNGRnFTb3M2TG9RZ2pFbzlQTmY5TXdTOVZiVGxOQ1ZSMGR1ZTlKR3lo?=
 =?utf-8?B?U3MrSVlKU1doQm5kdXRnZ2NrYks4RHMyZ0RQbU1XTEZ6ZGhQdXF6dVdZcTJB?=
 =?utf-8?B?Z1RyUnNNZUd6N1NqanVKMERtdnlEdXE2d0tiTUZ5b0lHanIvOUhEZ1hRckQx?=
 =?utf-8?B?d0NMUmlobTZDblgzVE5WN3hMK3FXdDRrNVBKendJb2lxVlo1aXhQTXQvaUtQ?=
 =?utf-8?B?Mk1mT3diUVVYWGdGdnR2bUIySG1EbTlpMVZXVWNpdDlibDdvdlFXRDA5YTNp?=
 =?utf-8?B?UjhReW9qNG80aFJBeXNaYlQzVStKTWZnOUhZcFZlY3ROdGhRRmtjV1BCRTJR?=
 =?utf-8?B?OVFMOWNKS094amY3VTFCR1QzdHJuRlNUNEVidWNKejR6TkRuV1Y4Y2lpZGFw?=
 =?utf-8?B?ck1hV0I1SWhKR3Rremd3cThieUhUVkxJbjc0NUFTMUNsQTBNY1hpcy9YWkZm?=
 =?utf-8?B?ak9yT2VBN01GSFBiSzh3UXNvRWN3MmxaZW5oTVVTYkNxR2xYdTZ3ckNHS1Yy?=
 =?utf-8?B?U0g0bk5WUDFmWDRvZ1R3VWN2blNzaTREbXpVbitXMm41OWJic0RTOGt6RjF5?=
 =?utf-8?B?YWVzM1RjQmdVZGhzVktmRkM0TXVwMHVOMFhZU1E3QkEyUnUzT2dtVEgvMkJU?=
 =?utf-8?B?ZWVxWkpLSmpKb2ZlZzRtdkVsMzNJdGpKajYxSHRaU2lJcThmMW02OEdCaytS?=
 =?utf-8?B?TWRiREo5NS94MkVtVWkxcnZyVWc3MlBZeEM0V2lBSUN5c2NnWnpkU0VEVTRN?=
 =?utf-8?B?V25GQ2p3QlVaaUpCNDNFd3BOTi90a2dUa2V3ZmJud0xNblNTTEYrb3Avb0w3?=
 =?utf-8?B?dDl5bnRXM01qaEJNT1UrUUlsNWlpdFV4S3YxWmtyd28rSjVlY29uZTNqa2VQ?=
 =?utf-8?B?RWRwQk9oZG9iOTJSOEwwenp6VmdUdGs4WVV5cXJ5N0tFeDF2ODdkNUF1QmpL?=
 =?utf-8?B?TzJtK0dHRmxTaHlxL1I0Q1hvbEFFaWVoRXN1UmxjeVVMdTZKdnhsaXlLK2ll?=
 =?utf-8?B?NzQyVWdTR05FVG56OVdvU2pNT0QxUEVVTGwvS0RFTzNtWG5Sdnd5eWdlVnhh?=
 =?utf-8?B?djAvVVI0MytDRWFFMXRMVC9LbTROd0RNdlgrdE13eE5NRTF6Ykg2UCs5emw0?=
 =?utf-8?B?OEtDSkVvUlVCcnVGd3ZxQkxXR2tub3h0ekk3dnV4REpYelZPOWVNd2Fva0Qw?=
 =?utf-8?B?UFAvL2RvS29NV1NDZHg5QVRsV0JvZmozeStzM0xwb1lrY2VLcy9iUXNzYSsv?=
 =?utf-8?B?MjQ3VFhFZzc4UkVxOWFaUUlkWXdOV2k3VHpxb2kzWWFvQVQ5SDRmVFM0OUlm?=
 =?utf-8?B?R1BGRnJFaXBkUVpkQzJsY1AvamdvbEx6QWk5dEZHM2d2K05RYnE3NGhDWE16?=
 =?utf-8?B?cU5PbkozZm8xbWZjOE5iclVoNW4rK3hHem9KT1BtbUFhSFdSakNBWnlvSTQv?=
 =?utf-8?B?cHZOaE0zNE9NSXRCRTdXOWJpOFVoTXp5NjdZa2ZqS3RHbXRIamh6MVZWRnBX?=
 =?utf-8?B?MVVYbHBMS1Z5SjBGbWkybDJkTmx5MkgxekxzcWc4YjluM0ZqaDR3NW1LVlla?=
 =?utf-8?B?TmhTcmpTUExIOW5BYUN3SFFpd1ZOTHFYUWNwa3dhclBkek0xNm4wNHpmeFls?=
 =?utf-8?B?d0FhOTgzcVJlTENEbFlLekY1SDhZREttTU5LOWN5Ti9uYU9RSmxjT0lJYmxy?=
 =?utf-8?B?cXNDc2N6VnBqWlJ5dUF0ZFJvcFNydUw1STdBakx0dkMzRnhyNkRCNEFKWFJ2?=
 =?utf-8?B?cXBNRy9KNS9RekNGQlkxVlN5bW1BUXdXNTREcm5Kei9MenoxWUE0dkErQ2ZX?=
 =?utf-8?B?Y1YrZGZDRzZ6UDgzVHhCK0JDS2hyb0ZSNTlkNnZtV1hZTnE1MlVLZGlLNjNC?=
 =?utf-8?B?Z3h2bGc5Z1JLZDlrbjQ2eVBMOGxBSkhiNWpZU0pqRHl6VitKMWltY25aTWdJ?=
 =?utf-8?B?M0hEQS95L1VQdTczd2dsdnFHUEdsa05CVlRMQlVtK1oxUzdZeFBDbkgzVnNS?=
 =?utf-8?B?MG5pZmE1YnZpeFFIL2JLUnRPV3RzZVhaSWl0YzVGdWowdjhLcUhMdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109d6e04-fcc2-482d-d0dd-08da10abbf42
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 11:11:46.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsLighPRfgijHR8mhzpsW9VHDmkwOEUtdsMDGoS6JWyI8RDKfHf/ie1JLttaxJVcc+h1JDOIBo3ys7GnMdrRXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3277
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10299 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203280064
X-Proofpoint-GUID: V0AkBFIpMX1ZeetWorBk5pJU3Tr77uoY
X-Proofpoint-ORIG-GUID: V0AkBFIpMX1ZeetWorBk5pJU3Tr77uoY
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/03/2022 02:16, Boris Burkov wrote:
> On Wed, Mar 23, 2022 at 12:52:15AM +0000, Naohiro Aota wrote:
>> On Mon, Mar 21, 2022 at 04:56:17PM -0700, Boris Burkov wrote:
>>> If you follow the seed/sprout wiki, it suggests the following workflow:
>>>
>>> btrfstune -S 1 seed_dev > > mount seed_dev mnt
>>> btrfs device add sprout_dev
>>> mount -o remount,rw mnt
>>>
>>> The first mount mounts the FS readonly, which results in not setting
>>> BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
>>> somewhat surprisingly clears the readonly bit on the sb (though the
>>> mount is still practically readonly, from the users perspective...).
>>> Finally, the remount checks the readonly bit on the sb against the flag
>>> and sees no change, so it does not run the code intended to run on
>>> ro->rw transitions, leaving BTRFS_FS_OPEN unset.
>>>
>>> As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
>>> does no work. This results in leaking deleted snapshots until we run out
>>> of space.
>>>
>>> I propose fixing it at the first departure from what feels reasonable:
>>> when we clear the readonly bit on the sb during device add. I have a
>>> reproducer of the issue here:
>>> https://raw.githubusercontent.com/boryas/scripts/main/sh/seed/mkseed.sh
>>> and confirm that this patch fixes it, and seems to work OK, otherwise. I
>>> will admit that I couldn't dig up the original rationale for clearing
>>> the bit here (it dates back to the original seed/sprout commit without
>>> explicit explanation) so it's hard to imagine all the ramifications of
>>> the change.
>>>
>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>> ---
>>>   fs/btrfs/volumes.c | 4 ----
>>>   1 file changed, 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 3fd17e87815a..75d7eeb26fe6 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -2675,8 +2675,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>>   	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>>>   
>>>   	if (seeding_dev) {
>>> -		btrfs_clear_sb_rdonly(sb);
>>> -
>>
>> After this line, it updates the metadata e.g, with
>> init_first_rw_device() and writes them out with
>> btrfs_commit_transaction(). Is that OK to do so with the SB_RDONLY
>> flag set?
> 

It is ok as the device-add step creates a _new_ sprout filesystem which 
is RW-able. btrfs_setup_sprout() resets the seeding flag.

  super_flags = btrfs_super_flags(disk_super) &
  ~BTRFS_SUPER_FLAG_SEEDING;
  btrfs_set_super_flags(disk_super, super_flags);

Thanks, Anand

> Good question. As far as I can tell, the functions don't explicitly
> check sb_rdonly, though that could be because they expect that to be
> checked before you ever try to commit a transaction, for example..
> 
> If there is an issue, it's probably somewhat subtle, because the basic
> behavior does work.
> 
>>
>>>   		/* GFP_KERNEL allocation must not be under device_list_mutex */
>>>   		seed_devices = btrfs_init_sprout(fs_info);
>>>   		if (IS_ERR(seed_devices)) {
>>> @@ -2819,8 +2817,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>>   	mutex_unlock(&fs_info->chunk_mutex);
>>>   	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>>>   error_trans:
>>> -	if (seeding_dev)
>>> -		btrfs_set_sb_rdonly(sb);
>>>   	if (trans)
>>>   		btrfs_end_transaction(trans);
>>>   error_free_zone:
>>> -- 
>>> 2.30.2
>>>

