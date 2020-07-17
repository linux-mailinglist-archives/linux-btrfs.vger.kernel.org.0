Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DD1224216
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 19:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGQRlk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 13:41:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgGQRlk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 13:41:40 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06HHYTIY019621;
        Fri, 17 Jul 2020 10:41:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LNSvaTGE551xmd9dpGFR09hkYP5zenQHWtgccbhecmk=;
 b=VKVs9y312T300YXCy4EuxaVW1FBvVmrzR3O3HYHMRyWRVNCOm38b0sqPm+0rcgERz8zB
 +cbx14an9NyUwVQMiu5gd+2P4PXa5NNJcwwqEHEvzVSM83osoXNtEfNYExNv1HATGgiq
 R/rRQHptv1tRc/H0aB3MQPT9fAShC0yoUmw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 32afftgkby-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jul 2020 10:41:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 17 Jul 2020 10:41:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXjhVVD21VTlBc4bHEQxtPs4c7uytJXSyuSi5zx4dxlQqp+wBvKF/bDDobIwemd4uI5Ix/Q5Ez/b7rqftlP1ss+bbxb1orLBI2TKKfdl87ZpVccFoDm6gkSK/OS7JxNVsFW9cb7Q9PZraFl4yVpJDPycQHrK3TWjq6hg3AxU5I6Jr7G7CtWTzAvINfBIjH+dV9PZqDwA7I6QnTpnQiaH7o7Gech07NNhIOJbZ9fjpk80RNlz2j8fyz+v5I0GN5Kgu8qU6aCYL+vh6E69TACDV+NLIygVUgNxNGaU6pOPaKrzN3GrgNBzUhdPAF+Ejidohi9WY3uGW4Fz1yzFxBxWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNSvaTGE551xmd9dpGFR09hkYP5zenQHWtgccbhecmk=;
 b=aK28eIUSexYaRr/Et5CjsrYKdi/EJ3twpBqUENlI5i6BzcG2bCR5bmeXqfZKxJZOqxAbPkKgQpn1K+7M85Ptf8DRD1pe2oQM8OOdlDFzqTKoRQKRwkh9NlmHfXKQKHETRJDrggFiL7U2DWNYI9ub+/x/7ZOiB2/JsKt6m+FBQeyjtB9pkwJmchTMc33p5bMWGnraUiZDqTcrXT0QPBLe7ixdzW9Kb/yQM3I7fW7D0UmA38pO3kEbfrBHiZBcMGnf+gKsgDqDk3gCr1ZQJ8LK3OWo4/VvOmDqHdwedkLWyMdr6p2gDtZEdLXv0Q2rFSQPXyAWe5Z6DbHMm4+qX5YOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNSvaTGE551xmd9dpGFR09hkYP5zenQHWtgccbhecmk=;
 b=hKti+BWUhzTVC4V3iY9sHRCNUiY+FoBxChWPV8kAVrzlVN6BS2hpce9gh0fPT7IJJHGE33uvkbHgnQyV3OD2B8is/rbDhWepCjn4KAVwzPuxrq9qyw/YoRgBMbLF1ctT1l5KEbgHHqoKdq2+6W6fhXvUXMmsgHGDzQ/k9HY9LDU=
Authentication-Results: synology.com; dkim=none (message not signed)
 header.d=none;synology.com; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB3582.namprd15.prod.outlook.com (2603:10b6:208:1b5::23)
 by MN2PR15MB3725.namprd15.prod.outlook.com (2603:10b6:208:1be::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 17 Jul
 2020 17:41:17 +0000
Received: from MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::e9ef:ba4c:dd70:b372]) by MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::e9ef:ba4c:dd70:b372%5]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 17:41:17 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Robbie Ko <robbieko@synology.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        David Sterba <dsterba@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm : fix pte _PAGE_DIRTY bit when fallback migrate page
Date:   Fri, 17 Jul 2020 13:41:14 -0400
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <3F3A624D-8323-411A-B367-C88957A01F4D@fb.com>
In-Reply-To: <68879817-1507-f42e-7f48-8565145754de@synology.com>
References: <20200709024808.18466-1-robbieko@synology.com>
 <859c810e-376e-5e8b-e8a5-0da3f83315d1@suse.cz>
 <80b55fcf-def1-8a83-8f53-a22f2be56244@synology.com>
 <433e26b0-5201-129a-4afe-4881e42781fa@suse.cz>
 <20200714101951.6osakxdgbhrnfrbd@box>
 <a7bb68ef-9b33-3ed7-8eff-91feb2223d80@synology.com>
 <20200715081148.ufmy6rlrdqn52c4v@box>
 <68879817-1507-f42e-7f48-8565145754de@synology.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:208:237::29) To MN2PR15MB3582.namprd15.prod.outlook.com
 (2603:10b6:208:1b5::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.18.244] (2620:10d:c091:480::1:6854) by MN2PR15CA0060.namprd15.prod.outlook.com (2603:10b6:208:237::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 17:41:16 +0000
X-Mailer: MailMate (1.13.1r5671)
X-Originating-IP: [2620:10d:c091:480::1:6854]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7d942ea-423a-497d-f709-08d82a789b97
X-MS-TrafficTypeDiagnostic: MN2PR15MB3725:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR15MB37258698F7C249E72034989DD37C0@MN2PR15MB3725.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdAHC5vWobV0IXAO/Ka9HOCaBzamdQQhGgz7f6IkH673Cv/ZSaEkSQp5/7j+m8Klf/ivLLO1p9N2TT0kjVu/7oI8n33CuSWUQKXEVo1oZVlmVxfJ2y3GcTBdlYGnanFdWXX9Ct5wOXCPKeGPOPRSO171co08prf/rgdST9jg+/siOgxEnOc2G6gQyXYGSxtPE5Yw61ww383xbIr2yfhuPXdR/ZEvgn33sjteG2Cm++X9xl7FzdK2b2Gpj7RfrxDtSi3QrYyz3bOuIY1a0lExMzBmABlM8wZxHWYpzZHEY/Dz1xlEdPIBklDs2HAXgJ8RJatGPL4pYPQ5bWChz776/HEDLbnezNLk51C+CHEJygv6a7jzAD/LGMbdyxctWK7hPgvsqVQC9abj3Noyhe0+r05ZjUTd0BtBnmr+SnD4yEU3xclE/tcPdm2TsKYTDWhI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3582.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(136003)(366004)(396003)(376002)(8676002)(53546011)(66476007)(2906002)(52116002)(16526019)(66556008)(478600001)(66946007)(54906003)(86362001)(316002)(5660300002)(186003)(33656002)(6916009)(36756003)(2616005)(956004)(6486002)(4326008)(8936002)(78286006)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 35ZXdIk1UHjdTUC8xvlScuyfh/UFxqp+KAV2HCYqzybkaADrTK/ukryFerhbUshscvoZY1CyzYj971+Ppj9sI4XAp7kWLmlqCZ33ncw/xevC0IKf0wUfOxiNbdMPXOzFTEzf7OO/EXVrfyc98LQTxZOXIP4+bKljjqf0B+03YlvcKScSY9bjfa+sxvpl7cUb8aUOMtPIKhzx9NX8aq/RiX8qTC3ICuTW/1K8OxEYftIpzrUAeDJZzncaP6GLr918ZVBA3SJjgPGOZYLW9/eS9ozdtOGPVALqBTNnuMiJzW0/+4EWvXrti4lxpxzmkX5cmD9dGpE6kTpXAe9lg+2QbcyrxlFRWRXkjygpDTbwW1Fl48hFyiLahGOyMryvLKmJhHir/W3nkzL3Bz/MOsNvX0LIdL7FJBSNx+lWC6qN71pzwRBYlzFecmShs3e2oFL6SuiXGCGlbr8xRFxr6G2joBmKjPpW0nfjWTEVGLGYzbENwcqhTinRE7Ut5BjOgoE04i20T2kMwuY/Ep0d/OSmEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d942ea-423a-497d-f709-08d82a789b97
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3582.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:41:16.9793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/CARL51aboHe4Z3vgVBg+OvTxcivplseNxHvbZEbqfk7qACkPGynz9sfYh9LQa5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3725
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_08:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxlogscore=937
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007170125
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16 Jul 2020, at 6:15, Robbie Ko wrote:

> Kirill A. Shutemov 於 2020/7/15 下午4:11 寫道:
>> On Wed, Jul 15, 2020 at 10:45:39AM +0800, Robbie Ko wrote:
>>> Kirill A. Shutemov 於 2020/7/14 下午6:19 寫道:
>>>> On Tue, Jul 14, 2020 at 11:46:12AM +0200, Vlastimil Babka wrote:
>>>>> On 7/13/20 3:57 AM, Robbie Ko wrote:
>>>>>> Vlastimil Babka 於 2020/7/10 下午11:31 寫道:
>>>>>>> On 7/9/20 4:48 AM, robbieko wrote:
>>>>>>>> From: Robbie Ko <robbieko@synology.com>
>>>>>>>>
>>>>>>>> When a migrate page occurs, we first create a migration entry
>>>>>>>> to replace the original pte, and then go to 
>>>>>>>> fallback_migrate_page
>>>>>>>> to execute a writeout if the migratepage is not supported.
>>>>>>>>
>>>>>>>> In the writeout, we will clear the dirty bit of the page and 
>>>>>>>> use
>>>>>>>> page_mkclean to clear the dirty bit along with the 
>>>>>>>> corresponding pte,
>>>>>>>> but page_mkclean does not support migration entry.
>>>> I don't follow the scenario.
>>>>
>>>> When we establish migration entries with try_to_unmap(), it 
>>>> transfers
>>>> dirty bit from PTE to the page.
>>> Sorry, I mean is _PAGE_RW with pte_write
>>>
>>> When we establish migration entries with try_to_unmap(),
>>> we create a migration entry, and if pte_write we set it to 
>>> SWP_MIGRATION_WRITE,
>>> which will replace the migration entry with the original pte.
>>>
>>> When migratepage,  we go to fallback_migrate_page to execute a 
>>> writeout
>>> if the migratepage is not supported.
>>>
>>> In the writeout, we call clear_page_dirty_for_io to  clear the dirty 
>>> bit of the page
>>> and use page_mkclean to clear pte _PAGE_RW with pte_wrprotect in 
>>> page_mkclean_one.
>>>
>>> However, page_mkclean_one does not support migration entries, so the
>>> migration entry is still SWP_MIGRATION_WRITE.
>>>
>>> In writeout, then we call remove_migration_ptes to remove the 
>>> migration entry,
>>> because it is still SWP_MIGRATION_WRITE so set _PAGE_RW to pte via 
>>> pte_mkwrite.
>>>
>>> Therefore, subsequent mmap wirte will not trigger page_mkwrite to 
>>> cause data loss.
>> Hm, okay.
>>
>> Folks, is there any good reason why try_to_unmap(TTU_MIGRATION) 
>> should not
>> clear PTE (make the PTE none) for file page?
>>
> This, I'm not sure.
> But I think that for the fs that support migratepage, when migratepage 
> is finished,
> the page should still be dirty, and the pte should still have 
> _PAGE_RW,
> when the next mmap write occurs, we don't need to trigger the 
> page_mkwrite again.

I don’t know the page migration code well, but you’ll need this one 
as well on the 4.4 kernel you mentioned:

commit 25f3c5021985e885292980d04a1423fd83c967bb
Author: Chris Mason <clm@fb.com>
Date:   Tue Jan 21 11:51:42 2020 -0500

     Btrfs: keep pages dirty when using btrfs_writepage_fixup_worker

And this one as well:

commit 7703bdd8d23e6ef057af3253958a793ec6066b28
Author: Chris Mason <clm@fb.com>
Date:   Wed Jun 20 07:56:11 2018 -0700

     Btrfs: don't clean dirty pages during buffered writes

With those two in place, we haven’t found lost data from the migration 
code, but we did see the fallback migration helper dirtying pages 
without going through page_mkwrite, which triggers the suboptimal btrfs 
fixup worker code path.  This isn’t a yea or nay on the patch, just 
additional info.

-chris
