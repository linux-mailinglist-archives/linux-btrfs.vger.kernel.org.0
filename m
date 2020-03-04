Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991CD179A16
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 21:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgCDUgK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 15:36:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57500 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728539AbgCDUgJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 15:36:09 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024KZfwq023776;
        Wed, 4 Mar 2020 12:36:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=sE4WwHlECRV1KTII489CwIOd3n05CETzPAm9swS5rqA=;
 b=iCO4+46pRu0bAudOsw25nGkvA1ETSNhb/YKRz8b6apyW4Q5pnGspUfGHGVQtD1T4ZJ4Y
 dBUCGzNiCTjJ5mZKpD82dUqdt6Amvtku+iHR4R8xyE55IlnR+NPEQhqv3GhmPEHHm1jF
 QxVCrkwLt9xRNrfl914NpaVsrvuDIGQNrIM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yjk74r2xf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Mar 2020 12:36:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 4 Mar 2020 12:36:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkCtkAVfyBfWwlEDYH4tHmME1hFVNcLBRDnam+WmmLmKxJ29GWnwbbxzNjxPotRLSx9V+XXzLccWBnpvnG0zbUEuCqI7vOY9tZVWoKk1vubr+R97doStHRr6tn9MLTE7/UZ5E5q1v9JIRSnsFNy11K65zdTVK+C4laO/R3Ttic5cvNlOnEFA/0vU/+rXkoVI0Dlgsy7h4SRi03FqRkt/dLyfReVj0oyV7yIYzj4wj/iytSBilEuw2HgWdOsgGyrubieizTBHtrIZjkPkeqoowfL4GZQ8lh2C4JXtVgF+nmxflqAiXmLzuLZozwor7PFyWZtFIv/o2y/3ddd/pH3HQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE4WwHlECRV1KTII489CwIOd3n05CETzPAm9swS5rqA=;
 b=exOiaK+OMQ0sD3YWi3W90Z1P1w96o6pK3ZTtA2Lu4Jcb0xIs5CwoT5IiLhsrTPrHiB+Tm3VGlCEntcqdnmcejNYA3Ze/JpY2+nq7jB+48fLysGi/z3vO+y7Ick5XJdgMda2AA0UOotMFAI8OgwiX51yu4H3sdSiVNej+YdO56B4v2qvVihcauj4VG/X9pVASAkwN6Lo8OD9BUJU9wxkMu6pj+IjJuK+ZaXk9/mZ43mzukT0z2LTERzydY8P8q37UjlBR2ylZl5hVeYjgxYCggwhbxN8q8wG/PnfC7J9Wjej1/LGXMEhW35yIaxUIg6gyU+/KKa4xnN8zeP6XJsZVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE4WwHlECRV1KTII489CwIOd3n05CETzPAm9swS5rqA=;
 b=lDn1MlHIePJlNQAQAx3U8tcek7QzxcK/GDVo6Mfw6ptVhdEm4ll9FUIQM52qZq7p+f2X6HNn+bi+IZnwfAtdf3xogNn0O/KD+Oaa7wX2D0Q9jiQshcMeEofCcCN86vl9knBadjbfKTDDHZRDvZJhOGYG2CWP3JGBcs9XGqv0k0A=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1901.namprd15.prod.outlook.com (2603:10b6:301:56::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 4 Mar
 2020 20:20:03 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::90a5:3eb0:b2a8:dc5e]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::90a5:3eb0:b2a8:dc5e%11]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 20:20:03 +0000
Date:   Wed, 4 Mar 2020 12:19:59 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Chris Mason <clm@fb.com>
CC:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] btrfs: implement migratepage callback
Message-ID: <20200304201959.GA800002@carbon.DHCP.thefacebook.com>
References: <20200304195002.3854765-1-guro@fb.com>
 <EE31DE08-36D3-4A5F-910D-9264FF973C30@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EE31DE08-36D3-4A5F-910D-9264FF973C30@fb.com>
X-ClientProxiedBy: MWHPR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:300:16::18) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:f3aa) by MWHPR13CA0008.namprd13.prod.outlook.com (2603:10b6:300:16::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.9 via Frontend Transport; Wed, 4 Mar 2020 20:20:02 +0000
X-Originating-IP: [2620:10d:c090:400::5:f3aa]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89993d88-ef44-484f-33b8-08d7c0796c16
X-MS-TrafficTypeDiagnostic: MWHPR15MB1901:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB19012CBC1978482065C1163EBEE50@MWHPR15MB1901.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(2906002)(1076003)(9686003)(16526019)(186003)(55016002)(498600001)(33656002)(86362001)(8936002)(66946007)(54906003)(6666004)(7696005)(53546011)(6506007)(66476007)(81156014)(8676002)(52116002)(5660300002)(81166006)(66556008)(6862004)(6636002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1901;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8no7Mvdv56eYArfk22Scr5hq3XyMXCEKAKL9d2Rens6Gn7JgGUh6DXyz1BzaXBqITazJXyLAl+IoqwIBvHPdE4mPursl45el6wv0XFAaePW+Eren7Yxv760y1zf3ga/wHMMqZfqQ7KR8Aqf/iuBvEGUxh4rAP9gU71lUHKvdM+9beXCHtglhaY8uofjXHhzqhVlDQbfYrr/2Bpx/oHHOSLFgSj0y6aw4F+Z09tpVeGo0I+eEy2sCQS5hRPmNbRAir136BR0Q4w7XBjtU64fgAhMWFuBzD+VfNRIkFlykuOHrVawLTU6xRdFA86hBHbYqRJ7Z4Dm5JNv2OwDIf4Y96Vj62Xqjr8rwLruZNkn3dXLG+gDag8cdWSIPt+686QUkiiYuUtvgSqbCryhl1X0rKvskzTVOJMwIgp8Pis2bj0g5onR01fussEeDaH4BJ9m
X-MS-Exchange-AntiSpam-MessageData: 5P/H+yv5By6o5selQJcylPwTigy0p1FS1XO2VpXH3sGGPDagmcHvhM+4qDUcVtkP40Jdc9s2B5RGXbJWJp3UvpON9aQpAE0mrYS3iJ00zSVvlLZHXhlSRv2tQP64LcftKY9MOMInoTxPfRwnagHwxAY/uzsLTeIeB/ui6qSra3i4rMifONda6jM/XQ6SBjEa
X-MS-Exchange-CrossTenant-Network-Message-Id: 89993d88-ef44-484f-33b8-08d7c0796c16
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 20:20:03.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAHTzm09Syy0GW3nhkcn8ZV/WbtjU6Tl+nXEaGbDJwscLqzcCBgcdoZ/3OCGMurY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1901
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_08:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=608 mlxscore=0 suspectscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040134
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 04, 2020 at 02:53:21PM -0500, Chris Mason wrote:
> 
> 
> On 4 Mar 2020, at 14:50, Roman Gushchin wrote:
> 
> > Currently btrfs doesn't provide a migratepage callback. It means that
> > fallback_migrate_page()	is used to migrate btrfs pages.
> > 
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
> 
> Since the default migratepage didn’t copy PagePrivate2, didn’t you find it
> was also causing pages to get funneled into the fixup worker flow?

A good question.

I've definitely seen a lot of fixup worker activity.

On the other hand the default (fallback) migration path is flushing
the page first (if dirty), so it should not move dirty pages.
If PagePrivate2 can outlive PageDirty, then the answer is yes.

Thanks!
