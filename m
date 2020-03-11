Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD103180D89
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 02:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgCKBbJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 21:31:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18828 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727506AbgCKBbJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 21:31:09 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02B1UwEv017793;
        Tue, 10 Mar 2020 18:30:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=6EeIkShzRpx8LtESmqO9Bq/tK1ZOH/TIoM37hWYXVpk=;
 b=E3uml6Qx/mnNC5aRAFFRG3n4tVuWhS6yrR/j/srLUK1Qsu08neIUDC3hsLk++8VdnrbZ
 SbEwFAa+tkErSnLjJvymd6+U+WxNLFH5ugKLzeWJ/OMgl8mTlnsQ7jwuMlE8JDImnFJT
 2Y1hTjW8Y2l8isTUImCBWM0W7fhIH2cntl8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yp25fntj6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Mar 2020 18:30:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 10 Mar 2020 18:30:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK2qXzNlFGRaVOZYB9pKgERqK42WF+Sk8gBRbPWlz/xtlNnZXBj/P/tUn68gh6xi+/lwaoki3L84gwgBpLFEhVGqieb+ezKh+tcRPNoqJxNZMWlUe57J3505RFIQvBIwxmEcI6u/qyBIZXuxlnZqaJR/n946aA6MrzdQsSnOnEbeZeOxGHP0RRMJ+8FrYVsLRQWEwUP6EoByeprRDQTWpAXpolE0bI5GaAZDdTmTEVVC8vBpBEDoUmPZQnpko4OZ0+uTkk73DM3j0Qcnqh7irbqya6+qmhVM72bG0dbD2IZ3//NdbZlKfR73kYcxRaRlJl79wjJInrM1Z8ODl1SVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EeIkShzRpx8LtESmqO9Bq/tK1ZOH/TIoM37hWYXVpk=;
 b=gMRvHnSWCSGfU9yiyTskhJiJgKNLoglrM17FaUbc5bkOf3N89sA1CqXDp/vYsWPBxAT1IfSBNMKMpxOTZCB8EudD4XS8AZ/M8QfaQUjAcDYvEQE5umHtXYgBvrqfYrGRc8q3oOeKXZrwh+W1YhCAureTtzXKUiFaCmnY7iJq6WELFgUjdOfS6aY0/hppq/PMbfbH79Vhr/fhtmooEzDnDicFaxL+3vj51FwQbrlDJIUWtHQ870+OgbZojhvUgVoEufX+zIutG3q5/+1TsF5kT8Iv5cPy1gqM//fZoKi/Cp1BaVcM/8OMudx2MOJ51tPYGmCcAj/EhwHmtO98Qtq3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EeIkShzRpx8LtESmqO9Bq/tK1ZOH/TIoM37hWYXVpk=;
 b=IQfGZ9aUCPbLNR87YzAErYdQl8t63fXVE6XDoe+GbqcTVudFVnMcXvKGZXkN6GX/43GN2EmvYn7g5YDc9/KGlhHAXE/boszC6ANK1B0YspJaZCFI2NH/gzkynKYhOOP31XGCpM9np3yY6lwYs0h+mVibpkBMiPpukPI4gGzRzc0=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1805.namprd15.prod.outlook.com (2603:10b6:301:57::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Wed, 11 Mar
 2020 01:30:34 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef%8]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 01:30:33 +0000
Date:   Tue, 10 Mar 2020 18:30:29 -0700
From:   Roman Gushchin <guro@fb.com>
To:     <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v3] btrfs: implement migratepage callback
Message-ID: <20200311013029.GE96999@carbon.dhcp.thefacebook.com>
References: <20200305005735.583008-1-guro@fb.com>
 <20200311004012.GC12659@twin.jikos.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311004012.GC12659@twin.jikos.cz>
X-ClientProxiedBy: CO2PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:104:5::34) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:272d) by CO2PR04CA0204.namprd04.prod.outlook.com (2603:10b6:104:5::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Wed, 11 Mar 2020 01:30:32 +0000
X-Originating-IP: [2620:10d:c090:400::5:272d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0b5f23d-0ba4-4ad2-76c5-08d7c55bcb14
X-MS-TrafficTypeDiagnostic: MWHPR15MB1805:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB180557F0E397D91D830967DEBEFC0@MWHPR15MB1805.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(366004)(136003)(199004)(52116002)(7696005)(6506007)(66946007)(8936002)(66476007)(66556008)(316002)(8676002)(110136005)(55016002)(5660300002)(186003)(9686003)(81156014)(81166006)(86362001)(478600001)(2906002)(6666004)(33656002)(1076003)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1805;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJjug8M0z1GDaWmp5ExcgpWvHpmFSmvxeKguBcQzJnCEJ7dKTbmVnu9tVO3oJ8UB/cPRsjA5uAgHI5OOqYvS5Y2AWU2i/YKJSOXNeGT79Zeleotmib3tKdeCU1Emd8yDQz22W16gneRDkKkoUEQQWhp77acxLdiRFDcSeDjexW2f7bt2RD72rhO68DxKu6F/Lc9ioSCrhIEzq5MwY9YxHvnjfIm/yX0GudkuGxaPSS7p0BCh7KSb6+oscdKA4dY2PKmWzuUImtWur30KTT7XFg4X5vWDVb+my+itPeRClqIvaSen7u6i2DwGXB5Y+j3RtmQ64kkciZiObwftKwJ/f+akq8wzAWKXOAi/FStBfCBxxJcoo4ysUflmkQ6vmyFi9fzIMFbrnCglzjBofGVua+mLaHMZMxnFezncTxoHSrVJcoGp0jAwia1p8luC/TgV
X-MS-Exchange-AntiSpam-MessageData: zmN9eVkLyB/dNXn61+8DNsChbv0dvdYcuYSapNw0Mjw3uKCyATf2mBdq7W/KW5b+JkQZTRh2V1MOLscfGQzcv6CFALqDT5iyZxjUYiSE5Q15C59fuUCab9uZBPpMK6nUhhmjzz5AH8x4z7HjQG7ObXraiWtTbrccHhJYlCjxW0iCUYlZ+pNbg57oReb8kGZJ
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b5f23d-0ba4-4ad2-76c5-08d7c55bcb14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 01:30:33.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jn2L/84iQ027Ym/fB2LtgAVDPmz9FQ6Ru8KJghkPFCkCXirBhD4Vb3NRgrfGZ8gh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1805
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_17:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=1 clxscore=1011 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=963
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110007
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 11, 2020 at 01:40:12AM +0100, David Sterba wrote:
> On Wed, Mar 04, 2020 at 04:57:35PM -0800, Roman Gushchin wrote:
> > Currently btrfs doesn't provide a migratepage callback. It means that
> > fallback_migrate_page()	is used to migrate btrfs pages.
> 
> The callback exists for the metadata pages (btree_migratepage), so I've
> added 'for data pages' where appropriate.

Agree.

> 
> > fallback_migrate_page() cannot move dirty pages, instead it tries to
> > flush them (in sync mode) or just fails (in async mode).
> > 
> > In the sync mode pages which are scheduled to be processed by
> > btrfs_writepage_fixup_worker() can't be effectively flushed by the
> > migration code, because there is no established way to wait for the
> > completion of the delayed work.
> > 
> > It all leads to page migration failures.
> > 
> > To fix it the patch implements a btrs-specific migratepage callback,
> > which is similar to iomap_migrate_page() used by some other fs, except
> > it does take care of the PagePrivate2 flag which is used for data
> > ordering purposes.
> > 
> > v3: fixed the build issue once again
> > v2: fixed the build issue found by the kbuild test robot <lkp@intel.com>
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Chris Mason <clm@fb.com>
> 
> Added to devel queue, thanks.

Thank you!

Roman
