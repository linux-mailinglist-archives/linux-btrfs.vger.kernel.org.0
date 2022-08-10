Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D8A58EEA8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 16:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiHJOnL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 10:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiHJOnB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 10:43:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1683A5E33D
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 07:42:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ACxjhZ011112;
        Wed, 10 Aug 2022 14:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TjJs1UPpjziLrsgYxFKGeSCHvg0FwCRdJp5Ytc5V6YI=;
 b=lKEcrAY2g2/vwLPFg/OQtV4eV0l4KsLaNz5lJe2QdjBDvDSffB6qYVf4mQtO+fItSfBH
 2fxrNyM+pUoHs7VwsWmzm3VI13+6xBdPpF4HqxR6rYxcAKgM5SKTXzo1CguTqraeqgwU
 yh3+l4kpXL2HzEW8mlIByKEjL+tQofA7C+b1mZl2zPz7OwI9idZSl7y8VOgxQViXTS62
 Xoet6pTLanVrejAs/gKDMfWE9hucutTbsowLUPzZwjB3zr1833HU0B2kt8Zoj3hZ9jxq
 UccYS4rajgIHJNiDufrZvGBgp8OUXOOeo24/lkKWejCh+YruAb0GN5gh+Bepem0aMczk 7Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqbj59m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 14:42:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ACbWNU015547;
        Wed, 10 Aug 2022 14:42:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqj6ks8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 14:42:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1AYYPpQFgyznnAkRJqUwu6oW05WzYQuZ8uOZTVIYF5R5vlyATcbEZID07LVm2vedOO/YG3i2uvPORQ7Q9b1Okec61lfFCaJtf1RjJbG1rOoge3vS3szfnGQ9vIm+f9orp54nrYYCtgMM/rSGRNgg2sIKtFAJJ/a5PhUmQrXm35qJXVWnQQ1GoKyrra61sF6DkvKb04EpCKJ6L+ZcNBiz0xgg+gnQmYhBUnabPxIi2xZOlXqQGY89ip/rZo5Aw4YzieVNuKk1Z+Dn4fTOKfmT1LcVmSLffAmFEhAAw35mhSDzy5SdoEEyoud6y8slAeEzXRvwmzVLQqjUsf2JQjkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjJs1UPpjziLrsgYxFKGeSCHvg0FwCRdJp5Ytc5V6YI=;
 b=l5fNXJuEC9377TTJXrxDbr/rtsvzdFBJOSwUjf1ikdOf+uCLUg5UGgiw/xfKoi8456tp4nc4aZlUHrmE/KSOOVwmJJnEpp0CW6vI3HP8OhFksoLzjUj1bDgoXKgXLoBTm1ew4bLPI8Y4dw3BLRtEBhko8/gK+fUOTJ27Q5S1X5F0HI+znxcZbjoettTFreWr1cpwMCDmJEl0HZ4R5UKZW6qnzAsIOjGt0Q59CzdjjqYsYKqqGQCUkRoTOGvKzNXtsieBdtXy1OiyZhsIKNjCjQNoZvjcBLlIjQ/zNDmJMdaR5kOFY5KBW4FAAHCiq3XNnzhCLKuS+jEqz/zTt65/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjJs1UPpjziLrsgYxFKGeSCHvg0FwCRdJp5Ytc5V6YI=;
 b=WJxFpb/+98f5ezZLC5EwQEDHnUo6z6adpcMijOCIvPQT4ZsSyozdgAMwQ8+/FKoMrShEPZbZFcEj01xgeQguZ5FHu1GcdtIlCnn8a6ymMd4XGLKxXegWpVPnPGWnjs2iTiJyvpzNTok4lscp/P/5bLKTou1OzSjRSRFv/1iXyjc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5791.namprd10.prod.outlook.com (2603:10b6:303:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 14:42:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5504.021; Wed, 10 Aug 2022
 14:42:47 +0000
Message-ID: <357c360d-5cb0-a6ad-d87a-2f88a73ba0eb@oracle.com>
Date:   Wed, 10 Aug 2022 22:42:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 02/11] btrfs: move btrfs_bio allocation to volumes.c
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220806080330.3823644-1-hch@lst.de>
 <20220806080330.3823644-3-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220806080330.3823644-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0128.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 991de06b-b7dc-4e83-c607-08da7ade9758
X-MS-TrafficTypeDiagnostic: CO6PR10MB5791:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOk3pn9pybj74eeARrceralZlLNwIGju2HHRZXydz8IllQd45hfXWbFh30pJwcj/5T5LlxFKX637jv46SCf2t3k3mHjwXJZE8VFG7liJxrn/FkKrswV/A10DSSzw2604WzWLRBy1e37Ng65nXhxfzO7X3/1KLuIVxvZRZ00G3CWu7t/P10NOFm5TtTuDacUf0jrQyfATHn4AncZaemIKEjVajC+0IdgIevzaDXZXLy9ei8ehnfZ9qdIAJ6i9jGaEmMfiRWRk4T98DS/CxaH87fC0vjrpiHXs18Ux17aIXXsK97czs5vYT7nXgZb8NWVzTfE1+rZgSf/Fecq+OhozR+LcxluHhNjo8731yqqfGtYNpj6OpoJ1wzDE6brqxyJRAQiSPRVHQI3fpIOkR3xBtX0hrfty9gr/NSFyM2+vfMWgVoXmlGZAUbnRoe/aJIz/Z66P8WYy5WPZcMpkmWkAAiSfU4y6wtDrofkB6VzaFoP72GSUYpl7a5bmwMvpCmXKmtkbsSRXaapnTAKMfkRPRhxrThF3wFsXU08k44BG8J80FvB3mveo+EgqVY95z8o5WbhPVffbn9463MjeVJmsERrWjaY209fKPGiXpTglPxZG1hH/YWgHXuv8lTjD1mlpEH0RN5n4sW1lkU6IU2zHRi3MM6qZ77M4dOaXtXXwLJ/S8ALvxcZ7xNoLO/y4DLg4ghgJcqjLZLz1Qr+PgXvymKUIKnFnNfe/3j7oDcdN4v9JaMBd/3+U3/vV8bA5WVB5FhYhYJL6DIjxZNrpZNuFn78bIMAcqZ2GF5H4LULR6VurnLwaTtx/awfNTwMCi9UwWe/03sdoN2UfdsOphu2AtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(39860400002)(396003)(376002)(2616005)(186003)(6506007)(6512007)(26005)(83380400001)(53546011)(38100700002)(5660300002)(8936002)(66556008)(66476007)(8676002)(4326008)(66946007)(44832011)(2906002)(6486002)(41300700001)(6666004)(478600001)(316002)(110136005)(54906003)(31686004)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkFYSjZVekMzMEx3aFhHaTNCQnlkN0FoMlU3c2FEcXFodnc2dTgyRW9CRzJ3?=
 =?utf-8?B?VG1WbFhyMS9ralRNVXlJUys5SU1DUFk1czJIdnVYdzY1Z2NGR3FaMjdiWXB1?=
 =?utf-8?B?UzVzRmVlcEtYKzEwSEFabjkzZ1NDV0hLdFc2YmtKb3ZJanlSOVN1bVlTOG5B?=
 =?utf-8?B?OU5xMUlCdVAzMlRHZzgrbitTdlNpQjU0c2xOV0ROMjQ5cUk4VmZ4QjN0anVm?=
 =?utf-8?B?ZVlyZXBzckRZeFA5SVFNRkxJODlKRWg5VjNDMkVaMUlEK0VJQU5QZW16czUw?=
 =?utf-8?B?cjljZkNCemg4WEVHaVdGbGVEV0d3Y2VScFBHNENaZ2ZoU1A5MXNXS2Irb1NX?=
 =?utf-8?B?VGNqbzl0Y0xMUDFNcjNOVDRDcU5FbEh3eHZzN1Y0WVErNUltS2dQbmdkaWd4?=
 =?utf-8?B?MW53bjhlRTA0N2dzUms0OTJJRHZ4R2lldGk1akJGUjJuZWZCRGJrV2lIQ0c1?=
 =?utf-8?B?SVNURUJaYWVNQmtITWYySFBHSkpZdUNxbDQ2akI0eE1KbFNTUCt3YnZWZndS?=
 =?utf-8?B?UWVHeTdvZ1ZQVFJvd0lkYmdpK0JvcEhpVk9BZE9qY1pWY0RPRWdWQnB5c0Rl?=
 =?utf-8?B?cHZwNG5xQnkyMkNJOGxpWDliWGRDb3cyL283clZDRXdLdUd4TzBCUDRpVmN4?=
 =?utf-8?B?eHhla0NXd3lDYUJCVlliVHg2UGFoQ2h3VlEwbDhrWVp3TFRaVjQ0WFdlaksx?=
 =?utf-8?B?RG1XZEJDNzJhMEQ2L29iOHp3NnZzMHF3UldSZkhDWVFrQ2J6NlhzSmV1b0xz?=
 =?utf-8?B?QW5iWE5RdVlKeGo2ZWN2WmlGUVk5VHpORkEwSTcrSXZlV2hXMlZMYllDMVor?=
 =?utf-8?B?ODdLbnhndGJ6b2I1NkdkQ0R2UEZhMnpZRHIzK1BoSk43QWpTMGwyNzkvR0h6?=
 =?utf-8?B?bEwxNVo5aHV4c1lSMkh1RUNncmR1RkpTcFl5Z284VG1OUUxxZ0EwQ0hsSy80?=
 =?utf-8?B?V1M1ZjRnaklhYVNtYlR4T2xCdGN3anB4RzdDMGwwR2VObjhZREViOWd6V3lU?=
 =?utf-8?B?QzlaTW9hZU9pbXdiVGg1Z2ZEN0YzM3d5OEVON3hPQStmZFMzZ1hQSmFIL0Yw?=
 =?utf-8?B?Z2phbW5jNXpiWHJoMzJuYXF0MzQ1NExBcStmYnNGRlBWVW1UVXRwVFUxRnpj?=
 =?utf-8?B?NWhTb2U1NzBxTjcwL0h3SytGbW5oSy9DT1EwbzQ3NG43WFM3YVVMc0VjZi83?=
 =?utf-8?B?WmVxYkxkVVRlUGcvb1hQMGg4UkNLUXRQY0tkc2FMemhJWGtWalI5bW91cElw?=
 =?utf-8?B?aWdub3JGNCt0MFR4RThTeDg3OGg1cUQxUzMrcUNkRUczSElWNVM3OHJ4dEJy?=
 =?utf-8?B?K2gzb2I0SlErOXk1d2I3RW8wVW1HdUNMaDduNjVoTkdRdEtLQ2hvVEFiVlRL?=
 =?utf-8?B?U2VDK3RMMUM4V2RqSUNGTi9YVnNZUVBnVHhIYlNqN3Q3OTI5d0djQzJoclRT?=
 =?utf-8?B?d2M1U2JycGh3NEVzZ3JCWVJzWFRPbEZPVjY5N0pEeVp5ZDNxL1VMb3NmYzlN?=
 =?utf-8?B?NVFRb244SVE4U0dMZktjb1dhNVh0VVRieUlzRllPcVhGQ09xRHo0WHhUVkxr?=
 =?utf-8?B?TVVmazhKUFNLeWJvQ2NUOXRkSkpvdGlBK0w4WjJ3S1BWTHZYZ09qY2tlUzl4?=
 =?utf-8?B?bE1wWktDOE1qeWMzZ3huMzUxUjkyVERPMlNvM0hVaGprbDdPd3hNelU3YzZB?=
 =?utf-8?B?eXZIazFFQlcxZ3pVd2RwRzhGTklQTFdXd3pUWEl5Rzl0QzhnVnB0dTJLbFJ5?=
 =?utf-8?B?RUhOanlBbUgvQnlpcm1CWWRGcUhpK3lGUkdhUjMxMGZRQk5QazBzendDd0dt?=
 =?utf-8?B?RzlGcmlIMGRnWWNDWmJsVFpYUDY4QUZoUExFWVdUOEpxb3RURVdUUmE0dktn?=
 =?utf-8?B?SnE1b1kycndZZFFlckJ5Z1NoVHlxU2VsVlpWem1pTFhSVWh5K1VOaXZqeVAy?=
 =?utf-8?B?bGowN0NsODlyaENtY29EY1ZQd3cwaE16eXhCK2U5RHNHUGNCdU5BencyTE8y?=
 =?utf-8?B?TWRMd3EwdU9BTk9MODFpSDJCNG4rbU5JVEpsUGJwMkdsY1N5QWtScEo4YTJv?=
 =?utf-8?B?Z2h3VHRMOGdjRXlTMmRBd0ZONjFzdUdGYnZNaVpPS1dTS3d2RUlDWGN2R3kv?=
 =?utf-8?Q?MH9umcF6pottefsUb2R9oXVO6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bzVnZzJ3bEk0Y2UvUS9lWUtNb3pRbGZlZ3FHVXUzOUZHOGZWcE5SQXZ1QTBq?=
 =?utf-8?B?NkE0QVNMcUZwcHRwcHN1K1lIbG9VdEdMUFVWUzdhenZZRi9rWk5vSFR2ZldG?=
 =?utf-8?B?bDdpWkMvbm02QkJDQUdpcXRXbEpicWxySDNlOVB4YldhbGs4OWk3d2FMU1dH?=
 =?utf-8?B?S3oxUkNTem9VbDQ3ZGJqODRVQXpsYUZ1SXlQSmxITG4zMWtNSjI2b1UyYjJ5?=
 =?utf-8?B?ZVpwaUJLbTBTcEg2a2Z4K2xLRjgvT0pNSGdzUHM2dnJNVWhVVzJPaG1MRkVZ?=
 =?utf-8?B?TEJxZ3RoSlVoLzcxclUvNUNnUmxmQ2pGY2JiVFhob2tFU3RvSTZrOVhrdlBG?=
 =?utf-8?B?ckNSbTZrOG5SeCtwN3hFSkdIWlF2Tm9ORlJGRjR3SDR3ZWpZQ2RMTUhZRHFp?=
 =?utf-8?B?eExxakhkMkIyWTB6M0ozS0ZSZnU0WVdlVzdFNmxWMXlIYlJ5Y0E5S3k3V3VR?=
 =?utf-8?B?QVJDNFFKWkVFVDZ6M3l5bmE4cmtQMjU0dHdmTTRsaE5mUVNYSUtUUEVJNTZ4?=
 =?utf-8?B?dC9nNzNwdks0Q1o5cjE0MFlmcmJORnhjUE16dFRxbGtGd2JmeWFNVzE3MGd6?=
 =?utf-8?B?WkViTHhDOWVGZXpScy9SL2FpbmhyblRnaFNFOTkyTHI1eXlSbkp5ejNubnVI?=
 =?utf-8?B?OURZUVZXVmlMcmRscndYNHo5ZXRxMmo4S2ZpRjRnOEZrRS92SkcyNElkRjcr?=
 =?utf-8?B?VlRXalJrTkpScUova2JhYnhqUHpZUThBY1BhYm9pd2FlU2Z6aDNUVTd3M09W?=
 =?utf-8?B?U24xakFvK1JyMWg3eC9zRUJwdm5VdkU0emVlcmNjaDZ0aXdadFRzanNCM0pO?=
 =?utf-8?B?ME5NN1kyM2l0aHdDR1lvRkx1T3lKQUh6SjVoV0hyV1RiUVE2OFQyUWJBa3M3?=
 =?utf-8?B?Ukp6NGloNnEvMndtU084NzBCdWRKdzJUKzYrUnpnOVZFRzlacE50aTJiaXBH?=
 =?utf-8?B?bERNbXcybHZMSktkVksyekc4bWxBT0EvSXRvc0NlNnBqTkx6WmlzNVFnRGZX?=
 =?utf-8?B?QnRtRVV6VnhKREZWOFhZbENLU21qMGl5MkNyZG16bW80c2t4R2J4VlE4YmdF?=
 =?utf-8?B?TEgySnFla1U1cDZjNldOKzA2YzBhZUFsRURtUHhnaHpSSnlnVFpxZEszUnNK?=
 =?utf-8?B?L3FxQkJqdmRLdVNOS0RYTE40cytScEhlRElFaDFxMkRFRWgxSlRrOHpJWHpV?=
 =?utf-8?B?VUppM2VNeThvZ3M4MVZKa2JUWWVydTZWV0QxTkJNZ0J4aU02aWFCV0Fzc05m?=
 =?utf-8?B?UmpHdWg2WEFBNW1KdE5vUndVbTlQV2Fpa1l6eWdjVEZQYW1PUGRqRG1WOTZY?=
 =?utf-8?Q?ONLx/7dlxN8SqoIx3j+Bqhbe2J32Ibryhd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991de06b-b7dc-4e83-c607-08da7ade9758
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 14:42:47.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwiNi9L3Z5DgrAkFsbuL9IQZunyILMJimJruFZTsFhIzhF8pQ0Cutf++X0oDp9xOgejTvU5b4EAKWimYoE3yrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_08,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100046
X-Proofpoint-GUID: b1e966Q8yqOjSKecYn03WZcFKAZpr8RR
X-Proofpoint-ORIG-GUID: b1e966Q8yqOjSKecYn03WZcFKAZpr8RR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/08/2022 16:03, Christoph Hellwig wrote:
> volumes.c is the place that implements the storage layer using the
> btrfs_bio structure, so move the bio_set and allocation helpers there
> as well.
> 
> To make up for the new initialization boilerplate, merge the two
> init/exit helpers in extent_io.c into a single one.
> 


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Tested-by: Nikolay Borisov <nborisov@suse.com>
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/extent-io-tree.h |  4 +--
>   fs/btrfs/extent_io.c      | 74 ++++-----------------------------------
>   fs/btrfs/extent_io.h      |  3 --
>   fs/btrfs/super.c          |  6 ++--
>   fs/btrfs/volumes.c        | 58 ++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h        |  3 ++
>   6 files changed, 72 insertions(+), 76 deletions(-)
> 
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index c3eb52dbe61cc..819763ace0aca 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -96,8 +96,8 @@ struct extent_state {
>   #endif
>   };
>   
> -int __init extent_state_cache_init(void);
> -void __cold extent_state_cache_exit(void);
> +int __init volumes_init(void);
> +void __cold volumes_exit(void);
>   
>   void extent_io_tree_init(struct btrfs_fs_info *fs_info,
>   			 struct extent_io_tree *tree, unsigned int owner,
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ca8b79d991f5e..068208244d925 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -33,7 +33,6 @@
>   
>   static struct kmem_cache *extent_state_cache;
>   static struct kmem_cache *extent_buffer_cache;
> -static struct bio_set btrfs_bioset;
>   
>   static inline bool extent_state_in_tree(const struct extent_state *state)
>   {
> @@ -232,41 +231,23 @@ static void submit_write_bio(struct extent_page_data *epd, int ret)
>   	}
>   }
>   
> -int __init extent_state_cache_init(void)
> +int __init extent_io_init(void)
>   {
>   	extent_state_cache = kmem_cache_create("btrfs_extent_state",
>   			sizeof(struct extent_state), 0,
>   			SLAB_MEM_SPREAD, NULL);
>   	if (!extent_state_cache)
>   		return -ENOMEM;
> -	return 0;
> -}
>   
> -int __init extent_io_init(void)
> -{
>   	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
>   			sizeof(struct extent_buffer), 0,
>   			SLAB_MEM_SPREAD, NULL);
> -	if (!extent_buffer_cache)
> +	if (!extent_buffer_cache) {
> +		kmem_cache_destroy(extent_state_cache);
>   		return -ENOMEM;
> -
> -	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
> -			offsetof(struct btrfs_bio, bio),
> -			BIOSET_NEED_BVECS))
> -		goto free_buffer_cache;
> +	}
>   
>   	return 0;
> -
> -free_buffer_cache:
> -	kmem_cache_destroy(extent_buffer_cache);
> -	extent_buffer_cache = NULL;
> -	return -ENOMEM;
> -}
> -
> -void __cold extent_state_cache_exit(void)
> -{
> -	btrfs_extent_state_leak_debug_check();
> -	kmem_cache_destroy(extent_state_cache);
>   }
>   
>   void __cold extent_io_exit(void)
> @@ -277,7 +258,8 @@ void __cold extent_io_exit(void)
>   	 */
>   	rcu_barrier();
>   	kmem_cache_destroy(extent_buffer_cache);
> -	bioset_exit(&btrfs_bioset);
> +	btrfs_extent_state_leak_debug_check();
> +	kmem_cache_destroy(extent_state_cache);
>   }
>   
>   /*
> @@ -3156,50 +3138,6 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
>   	return 0;
>   }
>   
> -/*
> - * Initialize the members up to but not including 'bio'. Use after allocating a
> - * new bio by bio_alloc_bioset as it does not initialize the bytes outside of
> - * 'bio' because use of __GFP_ZERO is not supported.
> - */
> -static inline void btrfs_bio_init(struct btrfs_bio *bbio)
> -{
> -	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
> -}
> -
> -/*
> - * Allocate a btrfs_io_bio, with @nr_iovecs as maximum number of iovecs.
> - *
> - * The bio allocation is backed by bioset and does not fail.
> - */
> -struct bio *btrfs_bio_alloc(unsigned int nr_iovecs)
> -{
> -	struct bio *bio;
> -
> -	ASSERT(0 < nr_iovecs && nr_iovecs <= BIO_MAX_VECS);

  This check was removed
> -	bio = bio_alloc_bioset(NULL, nr_iovecs, 0, GFP_NOFS, &btrfs_bioset);
> -	btrfs_bio_init(btrfs_bio(bio));
> -	return bio;
> -}
> -
> -struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
> -{
> -	struct bio *bio;
> -	struct btrfs_bio *bbio;
> -
> -	ASSERT(offset <= UINT_MAX && size <= UINT_MAX);
> -
> -	/* this will never fail when it's backed by a bioset */
> -	bio = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOFS, &btrfs_bioset);
> -	ASSERT(bio);
> -
> -	bbio = btrfs_bio(bio);
> -	btrfs_bio_init(bbio);
> -
> -	bio_trim(bio, offset >> 9, size >> 9);
> -	bbio->iter = bio->bi_iter;
> -	return bio;
> -}
> -
>   /**
>    * Attempt to add a page to bio
>    *
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 4bc72a87b9a99..69a86ae6fd508 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -60,7 +60,6 @@ enum {
>   struct btrfs_bio;
>   struct btrfs_root;
>   struct btrfs_inode;
> -struct btrfs_io_bio;
>   struct btrfs_fs_info;
>   struct io_failure_record;
>   struct extent_io_tree;
> @@ -242,8 +241,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
>   				  u32 bits_to_clear, unsigned long page_ops);
>   
>   int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
> -struct bio *btrfs_bio_alloc(unsigned int nr_iovecs);
> -struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
>   
>   void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
>   int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 4c7089b1681b3..96b22ee7b12ce 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2664,7 +2664,7 @@ static int __init init_btrfs_fs(void)
>   	if (err)
>   		goto free_cachep;
>   
> -	err = extent_state_cache_init();
> +	err = volumes_init();
>   	if (err)
>   		goto free_extent_io;
>   
> @@ -2723,7 +2723,7 @@ static int __init init_btrfs_fs(void)
>   free_extent_map:
>   	extent_map_exit();
>   free_extent_state_cache:
> -	extent_state_cache_exit();
> +	volumes_exit();
>   free_extent_io:
>   	extent_io_exit();
>   free_cachep:
> @@ -2744,7 +2744,7 @@ static void __exit exit_btrfs_fs(void)
>   	btrfs_prelim_ref_exit();
>   	ordered_data_exit();
>   	extent_map_exit();
> -	extent_state_cache_exit();
> +	volumes_exit();
>   	extent_io_exit();
>   	btrfs_interface_exit();
>   	unregister_filesystem(&btrfs_fs_type);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8c64dda69404e..bb614bb890709 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -34,6 +34,8 @@
>   #include "discard.h"
>   #include "zoned.h"
>   
> +static struct bio_set btrfs_bioset;
> +
>   #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
>   					 BTRFS_BLOCK_GROUP_RAID10 | \
>   					 BTRFS_BLOCK_GROUP_RAID56_MASK)
> @@ -6606,6 +6608,48 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>   	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, 0, 1);
>   }
>   
> +/*
> + * Initialize a btrfs_bio structure.  This skips the embedded bio itself as it
> + * is already initialized by the block layer.
> + */
> +static inline void btrfs_bio_init(struct btrfs_bio *bbio)
> +{
> +	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
> +}
> +
> +/*
> + * Allocate a btrfs_bio structure.  The btrfs_bio is the main I/O container for
> + * btrfs, and is used for all I/O submitted through btrfs_submit_bio.
> + *
> + * Just like the underlying bio_alloc_bioset it will no fail as it is backed by
> + * a mempool.
> + */
> +struct bio *btrfs_bio_alloc(unsigned int nr_vecs)
> +{
> +	struct bio *bio;
> +
> +	bio = bio_alloc_bioset(NULL, nr_vecs, 0, GFP_NOFS, &btrfs_bioset);
> +	btrfs_bio_init(btrfs_bio(bio));
> +	return bio;
> +}
> +
> +struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
> +{
> +	struct bio *bio;
> +	struct btrfs_bio *bbio;
> +
> +	ASSERT(offset <= UINT_MAX && size <= UINT_MAX);
> +
> +	bio = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOFS, &btrfs_bioset);
> +	bbio = btrfs_bio(bio);
> +	btrfs_bio_init(bbio);
> +
> +	bio_trim(bio, offset >> 9, size >> 9);
> +	bbio->iter = bio->bi_iter;
> +	return bio;
> +
> +}
> +
>   static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_io_context *bioc)
>   {
>   	if (bioc->orig_bio->bi_opf & REQ_META)
> @@ -8283,3 +8327,17 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
>   
>   	return true;
>   }
> +
> +int __init volumes_init(void)
> +{
> +	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
> +			offsetof(struct btrfs_bio, bio),
> +			BIOSET_NEED_BVECS))
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +void __cold volumes_exit(void)
> +{
> +	bioset_exit(&btrfs_bioset);
> +}
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 5639961b3626f..fb57b50fb60b1 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -393,6 +393,9 @@ static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
>   	return container_of(bio, struct btrfs_bio, bio);
>   }
>   
> +struct bio *btrfs_bio_alloc(unsigned int nr_vecs);
> +struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
> +
>   static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
>   {
>   	if (bbio->csum != bbio->csum_inline) {

