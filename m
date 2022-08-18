Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E230A59824D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 13:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244054AbiHRLa6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 07:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239816AbiHRLa4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 07:30:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BC2979DE
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 04:30:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IBO7Ek032453;
        Thu, 18 Aug 2022 11:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wIHNk8ke62szTEYPpDvtlQ2ek+kgiVMNHgo5owefd7A=;
 b=TbmG9p4f6bADiJUoCFTvP9iz0bROqluri7Zc/khFpc/nf2EeLC6w8bNuiYVSFGKlyJc7
 tznXoe+ObWB/mBKeRWbsgCPeynNTL1Uj6Gm1Q9bKEQQUbiR4PjHe53WmItMAbQIi0mBl
 o8pHuV8YyerdJEHZS0cEUFtvByYPw+ql/SInGFQitjfPHo5EKY0sblCeAzd/ePWBvy+7
 8LSe0mpT8ARSFFBZyxBrdLVkq/QrrWipS3TdLAJtTEGeNuFoWSWYTBdHqcBuN6gouXiG
 DSXCeJR51wCJZCjzTnVh5SiUDpKkD1lYDtiAnSlGu3hH+/5O9LOE5MeZpWiDK3zwsMN6 Ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1m9201ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 11:30:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27IAXuvH032104;
        Thu, 18 Aug 2022 11:30:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d4dhqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 11:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddAGchaF+gRtgLmsHtSAc1TMD1z2f8OeMs18y2k9sUZ9AXxUnS8uWix0wFsHox0eIrcuZWjLYdWh82j4j5TmMxIg/U3mg2dxC42C5kH/xfqRUYNITzRMtudHLMq6efnXN0JBjcyNoeNi+3uyDcZrjbwhJDvdTpzGHbwQ1Vqjs/cA46q7NAZDyHXr4F0cgG3wNGuDKBmR2fLQJdv//5d0Xpr5+NpHcJ8j+HcA+oNTYbkxlUeorzRfp8/kVxWHZwzCDbvHI17IAYn3EWm2y8ofdcS3nwktRvPZVmrzihhT4e72WuaxrJImuTxzlVh3zcLawg421gkLHQWHZ1G+UVBRBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIHNk8ke62szTEYPpDvtlQ2ek+kgiVMNHgo5owefd7A=;
 b=Q+QVJAjNG4f3sTXgw3emZ0/p8OXaGA7jjlRwgJP3M/mT3Ttcc45oY5m3VExspKOK4NcDxxSjTXxoW9z3w2qWRncw/LUJis63tn/LJw7hc22/jx12XKraJkofd2vUwv3vdTvmIGYiQPOinG6Eh3hPQ2D3oY5obEBD0Y/pBCTGJzw1s9y9IUI7RRKlojieEfYfUqBUnrSvLSVaAuYQHAHy5zEJy62qL5gWze7LPTk/K0neP3Bgyg50VbGBTmAa80JZX+E2P2EBZI06LN+3b6+FIVvir5U5qBScUCns/Jb6qrkT4PQyYo+Nv9p8zbTygWaG3HpPcmKi2E2zdhwhz9aMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIHNk8ke62szTEYPpDvtlQ2ek+kgiVMNHgo5owefd7A=;
 b=zO+Uuqlu6zb4HXv7YBrQini/E9z9kTUeBYzqD6DmEIN9G6AtW+w5r7dzYJceY+C3w8q7t9hJAhlQ6UtK3nhXwSZaRoFmHFaPouYjTfj5pR62B/VuFpKsZLC2fCj0S/CsLHGo43oqTPTgTnxKERxCsRAfaDYLcemiH0eET/khh3k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BYAPR10MB2693.namprd10.prod.outlook.com (2603:10b6:a02:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 11:30:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 11:30:41 +0000
Message-ID: <733214bb-80c8-403a-fb5d-7049eea7a71c@oracle.com>
Date:   Thu, 18 Aug 2022 19:30:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 04/11] btrfs: don't take a bio_counter reference for
 cloned bios
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220806080330.3823644-1-hch@lst.de>
 <20220806080330.3823644-5-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220806080330.3823644-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0df09cf0-b001-44c6-1290-08da810d14e8
X-MS-TrafficTypeDiagnostic: BYAPR10MB2693:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKw3oniZ4jVPpUbWKC49Q3u3S1y54ixFKl2RqXIb5M7yBr7xeKBIL71fj3W4ii1YfIUykIQeAU9tTyd/aUbQMuXJsRpNigxN9L7nXolG6Y5tzW+4nDfrXvRaVbMxzVznavDFGTF0iOnzYf9oMtHGWxVyi9gbe7Qr6LJTG/Vv2A/KO7Uo5WKt84OGYjEJaxVoVXbGXBqLB1kX/uQ5hbe1sT3hIWKsUU4KMM5VYzXseYT8gsThaH4w6kDKtqmToaOiCyMkAvnW0BD10BkobOQaI7kk6QOLWh4zdyBhJXoLx7GwmrPvExc3y6erJXZk5qMsVcWwAgIsSjvbr9hdEtWNwnf0gORfny3AhzoQgj8gNQ1pRBsWk0GwJrbI8sFWB8pfw97hej4qk1ZaugJPz6WODr6cvxGr49GWR8h+Zc+iPQF/51jBahx/3xNbvZk3Tn/D3XR7cwWl8MPSCMckkx9OAhAqTM0EPzJPJnKfFvlewrTMLnlSvuK2u2cQp6WKhLfh7EaxNMJo7dFzcx66zXNZAyv4VHgo3u+rkliVWKwAR63B3P14CIrP9YtZCcO/nLKTdFWsFc4pSp3xq8kOgnWEE/6bFBC80PL/0oHnuQtwBYog6z1t5TjZQfq6/huaE0+MCiQZe8PD8VTHUbRn7/QnkxFeQZ/0fWnVwZyUH3gTaKUD7pdUQ6NF3M+iKVgOxKoy1q4aZhru1D7ADzousy5irK6hVy2faUDbifghp/2/lHL/qtB8987A5m90REJZ1NKeRJmJ8N/FdrzUv4051lQgPK/rZfA92L5EM2LHGx++ha8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(54906003)(31696002)(41300700001)(6666004)(2616005)(86362001)(6486002)(110136005)(316002)(53546011)(478600001)(6506007)(38100700002)(26005)(186003)(6512007)(83380400001)(66476007)(66556008)(5660300002)(31686004)(36756003)(8936002)(4326008)(8676002)(44832011)(66946007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVU4ZTdXcUtUQkd4ZlVqbjJ0NGhISDMvOGVOUW5LWlhvSk9UUG4zZWhhTWVF?=
 =?utf-8?B?M2Q4OThJZFZIZXltUG5iWURFM2hNc3V6WDFWTktlYTF1NEpsTlBEd296bWxq?=
 =?utf-8?B?bFEwNlRLMWljV01kUXpSeE4yU0k1U0R3M1FaUEFyQ1djRzF4cS9Dcmd5V3BX?=
 =?utf-8?B?L1JqUG5kSmtPSEtSRm5GR1RXbHJEOURYblFrbytzaWs3TE5Ob3ZzaTNIMGtu?=
 =?utf-8?B?VTQ2UDh0NkdkbFhVNG5QNkN5R2hhbUR2SUdNWjZsT0tBc0pMQXNWQ3p5cVFp?=
 =?utf-8?B?NnBhbTZxdFpSVmFTa0pTc3ExYlBYOExzb0c1MlZQUnBJWnk4OWFqMjlSMEln?=
 =?utf-8?B?ajlEdzlLY0FyMFNzYnNJQ28vN0QzaGY0Mk1QemdvREpKN0YwRVFaWHFBRVJx?=
 =?utf-8?B?NjJKc1pPMTZURTJFcGt6U0t1ejJRTUQwOFpjdVNwOEgwRlF2WFBocVpmaEpk?=
 =?utf-8?B?ZXpjcUdKWld4QVI5UEgrUmNYUktsSlpKS29ydFNlNUFIVityR0JpZjFaS0dE?=
 =?utf-8?B?WHRrelcxUkxqNG1zcDJpMDk2dmhTVVJQUGlJMXJkK1FxLzFreUM0a1BndUhJ?=
 =?utf-8?B?cFdJUEZvYVdjbUNkR1NObUdrTWZoQ2tCS0VzOGljV0M3ZjZUWEJPdFJUZ291?=
 =?utf-8?B?NjEzb0s2bVNOUERPejJFcFZBRm5FamprZ0M1SkNGcGw4Wk1kYnYvOWtXYmFU?=
 =?utf-8?B?QnlSVEd2eVNVT1g2YjJQTjM3NUhsbnE3ajRVM1hvTk9OamhpUzY0Vjh1SFk2?=
 =?utf-8?B?eGpFMXFlbFBTQnBKRW5lTHBOd1FWTnNoMFBxdVNHdU1yNWZVWFZGbEJRVllP?=
 =?utf-8?B?eFM3b09Ld1ZNWmYydjlScHYraEFzRFlkaGNVQmQ2czZETG9MbGpNaFBlYkNy?=
 =?utf-8?B?YWdrVjB5eG9mbjY2K0tXQWpZcXhnaFdnYXhLc2FxR0hubVBpRlJLWnVYVE9j?=
 =?utf-8?B?V3lqSStXK3lVYjI4a251NGhzR1l6WlUrMnJzVDVMRWVRWHJKTlFXbkJwRnpm?=
 =?utf-8?B?Yk1DbnlyaDkwWXVKZDBtMU9hS2U0MDVCTmpvYzRsMm51MzBxYVp6QlArQXlT?=
 =?utf-8?B?T2Z1NHdCanlMbkU5dzlnd3Z1WkdET1VnMTlJbEZMUkFKSEducGdPT2xDZDhu?=
 =?utf-8?B?ejlSMWljTkRWczVieE1OTGd2S3N2RFBoRGtielNuNzBqUGc0TWtYdXJBRFJH?=
 =?utf-8?B?N0QxUERzOWdJS3JTeDdLUmJ5Y01TM2xTQllGc05VMmdZOEFLcEVDTG4yUTFu?=
 =?utf-8?B?UXF1cXpTOVdaakpuNW5mTWNyK0k1RUF3TDZzUExUMDdLcXNIME42a2VEdDN1?=
 =?utf-8?B?Wnk5MmdUN1ZBSnAxd0RjNUhEVmRwNlB5RVZJeExmNnFiRm5VM3FzMDBoOWZ2?=
 =?utf-8?B?K0gxVVcrb3BhUERtaE5FRE4wZzFCZjRlSTBOSVg5NWF5YStabGtnT1VmR3Rh?=
 =?utf-8?B?YzB4dWpFNzZJdG9PSWlyVFV0ZytncnZLYm9vUU1nNEkwMWFrZDZiK0Irc3N1?=
 =?utf-8?B?SU5Oak10MmQzV2RKVVA1citjaElLVHFFazl6NlNLd0tCdnpFcUEvR0srT0g1?=
 =?utf-8?B?N2xoblZFdXJDc1YyNWhrWmx5aHE5Yk93MzNuMjRUeHVDWWZBeXc2MVp4RGox?=
 =?utf-8?B?MWh5Vkt0SnNIWjhVZkVjVEcyY3lnZmp0S1FHVDdSNjZQRmx3TVNjbGZVK3l0?=
 =?utf-8?B?MnY0WHZ0ZUFNbVk0aUdRNDZiaWE3dll6aHU4NDZkdjlWeGxaOTlYQ1FtdGhh?=
 =?utf-8?B?alMzZnVKY041aE53NjBvakxJQVlSRzd6YmNlMzZ2RGpOc0RwRExsTjNMNHcz?=
 =?utf-8?B?aENLa092OHFvcitRNjFWeElKQjZESk40TThxTVpOZFlZM2JFYVpkL1pGdmRF?=
 =?utf-8?B?L2l1dXVzTVdsSEVpRVhPWk5BaTZkVXdkTDl6Ykxpa1poVS9UNEZjd2thSER6?=
 =?utf-8?B?Q1h0SHlqaUVoenB4UFRBWWxwS1hhbFF3MitHY3FrMmxYZitZeTVrcTJjNkVK?=
 =?utf-8?B?bWo0ZExJWGtFaHBkanVSMDV1bXo1VnJXRkRpbFBpcDJPVGd2dkJkalE3NFV6?=
 =?utf-8?B?aFZYc0ExOEpvT3ZvSXdIYXZqeXVNWWNqaTgya3gyczF3MG84RVlnSDUySThM?=
 =?utf-8?Q?Z+JQA7sx7lgLBsql3jgeBy8Jz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bndnV0hieEFJZWFrMGNvMGhFS1NVc1N6ZGJBdmV1QlJ1Njd6YW9KTVBzRU55?=
 =?utf-8?B?SEVzSXZBQ3lVTU1KbXRtdWxMdzNObnJBTHVGbjBwaFl2V1JiQk1HcWJkc01s?=
 =?utf-8?B?TVBRK0hhNE9sNDl2bU0yT1QrQStjQVFFNkFpblM4QldQZHVaUXplOEJSeXhF?=
 =?utf-8?B?SFZCOHI1a2NNZGE1N3dYQm1lcFdHL1R1ZUF4cGZabERUOXlJT3o2Vzh6aXhy?=
 =?utf-8?B?dVFTTXh4WTNDejZLSmFqWWJycHRBeW03Wk05MzhZbGZZVXd3SHhaV3ZVNEJs?=
 =?utf-8?B?SWNycWVGZTBmckxiaW84cHkxZkgzTE5pOVFIeWVaOXFpUFJTdkJtRTZ6ZkNY?=
 =?utf-8?B?enFBUnZ2OVBmVS9NNmRSemJDNW5ZYmc5R0duaHYrb2R1V1J2ZEdGOGllWkUy?=
 =?utf-8?B?R3A1S0d2ZEZsNm5hR1BnL1diRjdDRkQrdjJ5bWU5eFFHWGRpRllhRVVINVdN?=
 =?utf-8?B?UDhHN3hJUk1pcjE4RzVjN3ZjMHZZMDRsdDVJQU5xUUsrM3gwSHhmV0xWUmVU?=
 =?utf-8?B?SXNkVXM3d1pqNVBGS0tBSXNhZlRKN0NsOVpESnFtQVhOZ1JCSnY1VzRZaHZO?=
 =?utf-8?B?L3greXorLzFzQkw2YnBTSmdGTFN0UEc2VysyTTdYK2U0eW9UTUxRZmZuMHFV?=
 =?utf-8?B?VnRUNXIxWkVXZzBNSUNEaitaM0kxVjFtK2J4cGJpUG9Bd25KMTg3SXFXTmRw?=
 =?utf-8?B?cmlGRDQ2dk82cytORmNZMlRIZGRDb0h5MVBxcDBOSmU4NXJhZUNiZ2ZPOXlV?=
 =?utf-8?B?SVJtMmluVGIyMWdiem5lTVluRGpQZjdlVlQvSE9idDRZWEFrS1QvQ1J2Slpo?=
 =?utf-8?B?UVQ0SGZNUTcxVHpuOTh0ZEFkTW54a2dia3h0YXdEVnptTlNzOUpGUmNYZXZq?=
 =?utf-8?B?eWhWOGk3dWJHL3FWZVczbS9iRmc0ZWl6VjVkS1NlazEybGF0NHBOZGY1T0cv?=
 =?utf-8?B?ckdXbEhnQTlhMlE5VS9qclA2TnoxWFlFaVNNTnBpbVdsMGFoN2tBY3JZdU4z?=
 =?utf-8?B?K0ozZTEvdEYzeXhBQ2crUHVnVStBUGpGb3hmUkpjY2VGUUNxSVBVTjcxckFT?=
 =?utf-8?B?OUlsaCtWd0taNUU0UXFQbm5WbUJZVHFqVjdKQUcxWFlvbWRtaXBxdjdneUxE?=
 =?utf-8?B?K2JaODNYbGxQVWxuSE1tK1dGNStuQ3VyN3M2L21iWTFDVlBwdm5DSlZuS1V2?=
 =?utf-8?B?a3VOdHhVYk9rU2R1aHRxS3FtamtKQUNkNGFrcDlQeWZpVjAwS2Z2TjVFWkZX?=
 =?utf-8?B?ZU81V3pBK0gxcEdReUhNVGZtUVc2Tll1TEtmVVpoS2RFNUhHL0podGIvVmgw?=
 =?utf-8?Q?Lmv9L5QMUmCto9GCtj7CX9vEYSJNYqz0EN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df09cf0-b001-44c6-1290-08da810d14e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 11:30:41.4938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDzIEICaOnrxa4o8hQBOHFH7sZuw2c5XhfrSPK0pH+9p6QPczUf9qMKJWaZXTO6z6UF0XuFXH47Rob275DGsOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180039
X-Proofpoint-ORIG-GUID: k1fF4_c0TFdSmdawNgSD80uJZ9Utsgw0
X-Proofpoint-GUID: k1fF4_c0TFdSmdawNgSD80uJZ9Utsgw0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/6/22 16:03, Christoph Hellwig wrote:
> Stop grabbing an extra bio_counter reference for each clone bio in a
> mirrored write and instead just release the one original reference in
> btrfs_end_bioc once all the bios for a single btfs_bio have completed
> instead of at the end of btrfs_submit_bio once all bios have been
> submitted.
> 
> This means the reference is now carried by the "upper" btrfs_bio only
> instead of each lower bio.
> 
> Also remove the now unused btrfs_bio_counter_inc_noblocked helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   fs/btrfs/ctree.h       | 1 -
>   fs/btrfs/dev-replace.c | 5 -----
>   fs/btrfs/volumes.c     | 6 ++----
>   3 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 51c4804392637..e9a1d0016804a 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -4079,7 +4079,6 @@ static inline void btrfs_init_full_stripe_locks_tree(
>   
>   /* dev-replace.c */
>   void btrfs_bio_counter_inc_blocked(struct btrfs_fs_info *fs_info);
> -void btrfs_bio_counter_inc_noblocked(struct btrfs_fs_info *fs_info);
>   void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount);
>   
>   static inline void btrfs_bio_counter_dec(struct btrfs_fs_info *fs_info)
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 488f2105c5d0d..c26b3196a3f17 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -1284,11 +1284,6 @@ int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace)
>   	return 1;
>   }
>   
> -void btrfs_bio_counter_inc_noblocked(struct btrfs_fs_info *fs_info)
> -{
> -	percpu_counter_inc(&fs_info->dev_replace.bio_counter);
> -}
> -
>   void btrfs_bio_counter_sub(struct btrfs_fs_info *fs_info, s64 amount)
>   {
>   	percpu_counter_sub(&fs_info->dev_replace.bio_counter, amount);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a73bac7f42624..014df2e64e67b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6670,6 +6670,8 @@ static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
>   	struct bio *orig_bio = bioc->orig_bio;
>   	struct btrfs_bio *bbio = btrfs_bio(orig_bio);
>   
> +	btrfs_bio_counter_dec(bioc->fs_info);
> +
>   	bbio->mirror_num = bioc->mirror_num;
>   	orig_bio->bi_private = bioc->private;
>   	orig_bio->bi_end_io = bioc->end_io;
> @@ -6717,7 +6719,6 @@ static void btrfs_end_bio(struct bio *bio)
>   	if (bio != bioc->orig_bio)
>   		bio_put(bio);
>   
> -	btrfs_bio_counter_dec(bioc->fs_info);
>   	if (atomic_dec_and_test(&bioc->stripes_pending))
>   		btrfs_end_bioc(bioc, true);
>   }
> @@ -6772,8 +6773,6 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
>   		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
>   		dev->devid, bio->bi_iter.bi_size);
>   
> -	btrfs_bio_counter_inc_noblocked(fs_info);
> -
>   	btrfsic_check_bio(bio);
>   	submit_bio(bio);
>   }
> @@ -6825,7 +6824,6 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
>   
>   		submit_stripe_bio(bioc, bio, dev_nr, should_clone);
>   	}
> -	btrfs_bio_counter_dec(fs_info);
>   }
>   
>   static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,

