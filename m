Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921C34C41EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 11:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbiBYKDG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 05:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbiBYKCz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 05:02:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF31B8FC4;
        Fri, 25 Feb 2022 02:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645783343; x=1677319343;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EQNTJeDW8CU76xi1MJMfi8Wi8yr/ubqJ4VTxnfbjiW4=;
  b=NI6KNwPMGVcN35ksgjQiigIBgs70ovb6hlxCwMU881kG0FjhB9L3Kw6+
   5PfJjNNPcZAu/CeKOrEQf8irZPa4UqLFHg+4P6PdLnN9AFQy+RNwhI0Zk
   PLFlzb9H/yaUA4VK8qz+Obr06UpnDlv9YK4vSjV6+5SIUaCCs1AlWblK4
   nDrKmLOPD67g10uduBCSRgR4fmQRJw8kyUA2ls15syptOi9IOahca1SYp
   VP7SgFUGA+bjmL+4GNrKDpBpyFtBs7U6P0a2WW+puLbYLVCe2NlWsBl5s
   7FZ57jkAzovqRNFNSEgXzS9P4BL17REm0BEZlcnAPqihUzaue8KePucTP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="233092324"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="233092324"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 02:02:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="506649988"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 25 Feb 2022 02:02:22 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 02:02:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Fri, 25 Feb 2022 02:02:22 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 25 Feb 2022 02:02:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggwrw/+uZl2atMfZHLKz+m3D69CVRIdxi1WPmkLPInRSDTti1YduiKaC/kwvQfZnWq17qatv+hQa9UW98VZAjKHBjHxOydVZ6bkQqmULAoUm2Z+6bzTA+zucgRTpee9ynang/ks6pe49u2fZyMwpYhddbtRjxmRgoFUyP3HJ7T0EKwi77bnrVjjlvakpL//nIswohPjKcbkO+kOpKuLRrBWTPtfZGyFJM+htmXG2CkLi2vSYvcG8FUOPstVrwZiU5wBjnP+yUxV0qZUS8chQ0IQLhmVLw7aVmCk1le8LgprH1IypvMTso+s1+fiSJ5prJDTgGC+IHn1B8gmt2qsiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmeUuoNuQggaAcsS7lhiJbmkZieLiJHxOTv5TYjb4l8=;
 b=PnwhQtyN18r3dqpk/VnD7t/gNs2cFRwfhNCihoIlPhwrV46kaAb9lYhWoPxFAkrr73WN4LzapJZDWF4GT4bSQNnFTAUad2XowOFRu88ELTq1czzekRZagOc+xEQ5SsCDEUJqjaSyEKVXHu9lQvzALP+LFLPouwsFvRyEHTBTOxImXIDS0lU9PsVFp53nPbceQat3NPR8aNHnF8Kyxj9ukrcpVy5TrJw1PMb79feAOUbjPIDbDBpHy3hqohKShlAwa7P9TD/AZ+tvzCn34jO+wGkSElyBO7OZiYyoD7TydzA47wOPFtAcRNMF+hCaHfLmuutxZqRccm0hXpvaOhGTCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by BN8PR11MB3618.namprd11.prod.outlook.com (2603:10b6:408:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 10:02:17 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 10:02:17 +0000
Message-ID: <e94b337b-38ea-8705-4dd7-c09ac6b98ec0@intel.com>
Date:   Fri, 25 Feb 2022 18:02:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: Initialize ret to 0 in scrub_simple_mirror()
Content-Language: en-US
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, <dsterba@suse.com>,
        <nathan@kernel.org>, "Nick Desaulniers" <ndesaulniers@google.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, kernel test robot <lkp@intel.com>
References: <20220220144606.5695-1-jrdr.linux@gmail.com>
 <0a2e57ad-2973-ea01-ceda-3262cde1f5aa@gmx.com>
 <CAFqt6zZsv+bMwbdqrcOMCZE08O_q7DGa0ejVAbokLybsSch5fw@mail.gmail.com>
 <a1d126df-a5ee-d47d-bfaa-95b3b221e41a@suse.com>
 <b2536c4b-bf0f-a2ff-58cf-ef7d17acaf48@intel.com>
 <CAFqt6zbCootaOTU3hGXZ0cBcMHoiNtXynzzG8oGw8R6fO4muhg@mail.gmail.com>
From:   Yujie Liu <yujie.liu@intel.com>
In-Reply-To: <CAFqt6zbCootaOTU3hGXZ0cBcMHoiNtXynzzG8oGw8R6fO4muhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::15) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c5e3664-e66e-4423-a6f2-08d9f845e7c8
X-MS-TrafficTypeDiagnostic: BN8PR11MB3618:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR11MB3618BF2DBB37518C6106F967FB3E9@BN8PR11MB3618.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgP2ITUlKGXCLjmhcjbONJ23iBnRM8L75T2S67Q/weJxmDdFsba4E87qzKTW5wZStOSvUUwdef7xtpHNaLe8rPd3b0rEozTvitMbqUvm+g+/MgI1Xl+Hq0X8B3t4NgJujkjSSAGdXrv3GR0yhO0FNroN8e3amGgv6kH8fM9fM90f6FSU0cDo3TPs1VLvswgON7N2C+7jnI3zB5yIC+4tfQQSVi9lo1QookrdP1BQpKhJLxCp812A222sx++shCHoop4zoHIsEfjTLBx8i1DMoMXjQCEVO0xFIJchbdHlIwDjL+CzfbUClR6OnAejriu7OPyciZk4E1MtQ/pcHTbVdkhVHnu0S1HFB+PxYiwQZ+ClFA3O32Py7bMGRjfhHS0zQoTQ2R1P4tSV0LKNTV4TXFvzdxwWx7IHw6/OOnfMF121bHc7hsLbcRvtykebbHhBmsBt+OmKHY/coa7WMSy/+mW9SN4hxv2OUMJ9sCkyl2l4fgwO5sAcdyVJpp0diIIZxqXJ5jBNmyT4Q81P2YJYUOpfuTrvwf4uvypjUqSVVbJfcUDcn9WxxRa/JPUmLKMeWETy+MlB7ZgDLHXhhQ1zt1rEIqyE8XPA7zt6/QEo1XAKEkAk5Wr616+hWlSz2Stkw0stgML/cfpfffdCSi5SGuVcWorvp4ucHHhhAZJP8mTNK01JEBkUpbHJn8ThQuxpGCp6CIszUKwVu/y08QucPLKEns3YSOjyVyfDUYzVsSbB6awqNBCl39bVgK4LV2qPAmC6h0KncRgh2X1vXEVZ97We4e/KMSMycj/iAbPYDI29V2r3f0mzqO3YLm2Y+4jv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(53546011)(2906002)(82960400001)(107886003)(966005)(6512007)(6506007)(6486002)(31686004)(186003)(6916009)(4744005)(2616005)(36756003)(38100700002)(7416002)(8936002)(86362001)(26005)(83380400001)(8676002)(66946007)(54906003)(66556008)(4326008)(66476007)(44832011)(31696002)(508600001)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkMwS0RjaGRvZ2QrQ2N0L0p1TjdlUVJubXlyV0NvV0s5VW9tcG9qTmtzcS8r?=
 =?utf-8?B?QjlIMVJUZjVXdWRLVk43Y2g1dHpDeVdLbWJ2ZjVlYmFRRUE4RUpyT3Ftdm04?=
 =?utf-8?B?Ri81K0gwZjI3bS9tdjNaTUtRSzNIN20zQ09ITmdQU3NMWUZkTzNjc3U2bzk2?=
 =?utf-8?B?R1gycDJxUjMyOWZFOXNidFRJU0tDUlljT1ozamc0OFkzdG56YWNIcVJGcmdJ?=
 =?utf-8?B?d0RBV1lrRDZ0VUNjQUtiQ0pLQXE1OXQ1WW5vWVdlZkFobDlHUXdrdEFQTlBR?=
 =?utf-8?B?d0JUeE9vMWxZYWh1Sjc2eWVDblh1TFVQUmZsclBvTndwT1ExdWlHZjgvU1ZK?=
 =?utf-8?B?djR3NFFoZkEzM25LbWVERDMzeUtqTnpKdUJCMlJsbnFsRWJFU1d0clFVMndR?=
 =?utf-8?B?WTl2VlExMzhOb1Z5SC9nTWFFU0EwcTdRbUkxN1RmdzBPSm9zd1ZqTXVrR0R0?=
 =?utf-8?B?THlleHpYWC8ycFRxR3dUNWZMUG1VVEZzNlV2aXFqMGtyWFRLSmNGRENPaGVI?=
 =?utf-8?B?aExMbVdoeWZNQWJnNjZkS2lZekFqVFlsRERad2xZUGRQdVVtMDVBWW0vYnc4?=
 =?utf-8?B?TFJDQ21iY0Z3YzVmNTdvTWE1TXM5cEVDV3d2QWtYOHoycXUwOTVGN3FaVnJu?=
 =?utf-8?B?bFlQd1p5MUc5WFRMaWs4U3phSVM4MmsyV1VSSFJKT0YxOVVXSFJ5V0EwNEJI?=
 =?utf-8?B?UWFFS29tOGVJby9GTXBGT0NydkFQeHdVOWovL2Y2T3pCSXFkdFJVdzJkRExE?=
 =?utf-8?B?Si9CR1FIUmVsOXN1eFRFdC9kNkpHaWNBY0VlT1lpWWM1ejkzVHlCVzJYRXdB?=
 =?utf-8?B?YnRvZFJ6dGFZdSt6VDFSMlk1L3JIL2hPN3NLYUFKcUprbUpCZ0ZYaWZ5M0Rs?=
 =?utf-8?B?V0ZGV1I0bjMzWU03K3kzOCt1ZHJnbHovRHRvWEJPTE5FdEhnUm4zWDh6K0JT?=
 =?utf-8?B?NWVWREtjaTAzcS96RVZpL2ExSEZieXRXSVlFemxGQktmTGZmaFlFZW5rc2FT?=
 =?utf-8?B?ZkQ2MmxVTmpkaUVVT1NweFVxc2RPN2F2cm5qU3hGNUF3UlJxY3prQk5nMmdq?=
 =?utf-8?B?bXd1RUJYODBIWXZpSGs5ZVhqOWZ6TWVJcEd5M010clpmUHE0M0pBbDhNcUNE?=
 =?utf-8?B?VGV2RnVGTE1CR3gvb1hpRmVhQ0FOeXE1bk9ISjBxNGdJK1hxUXpSOXpJNmdk?=
 =?utf-8?B?LzNNc2FpYnhVMDRHcExGeXJYeVROUG5yRkRYTG0zTVN2MnpGYUhDczhxRmhq?=
 =?utf-8?B?M0ZYTHM0endjdlBiOUN5OUxiOUE0T1U3c0FvWXoxaXJRV0E5QjB4dE1xazlV?=
 =?utf-8?B?ZFdML0xKYkFEbFh3YnpITEFJY1hkRTRpSmhnVVcvUlJqN1F4QTZMdEx0cVE3?=
 =?utf-8?B?a2J1UWFaNHpqRkQ2VU1qbTVySy9SemVBOHg1S0x4a3BKTWdYOE01WnVKODhS?=
 =?utf-8?B?V3lIMGo5Z2dRZHd2SzhqRFd3dEpJZGFnNmpqYTVJSWhNU3VUU0kxQWl4aUF2?=
 =?utf-8?B?VFkzWXgwT0pKa1h0cGhhRmJMYWRVT1Z1bjE1SHU0S0Q0dW95QnhkU011SDVx?=
 =?utf-8?B?ajg1bGdUUkgvdk5HV3NBdGdoVVBaOUJHRSs5RkdKdjNDR1ZaNENDS1VzQUZR?=
 =?utf-8?B?UlMxOERYUGM5dVdUWnZvaWhuZ2I3VkIzZXBXS21rVzlEVUYvVng3eXkvQTVk?=
 =?utf-8?B?dU9taUk0V3lmRVpIckJESVBRMFZaMDBwOWN5VTlYeUZzRllTdjQzUUg1U2Za?=
 =?utf-8?B?WUYxWVpqQXJkcUVFVlFJQnduTFVSSU9GOUg2Rmh1TlROcks5MmxpcjArWTdz?=
 =?utf-8?B?Q01KamRhVjUzb0tBbGt4TU9wazRVMXAyd2RxcUdqRVAzS0R1M1F3eUNnVmE4?=
 =?utf-8?B?MVFiMlNoYWNRZVN6emI3R2pGb3Y2TGd6dEZvU1lMZ01sUFEwT2JyRlp2NjlE?=
 =?utf-8?B?SDJXSEdrRWhickFobnZIZmV5bDhrWTM5amJSUDBSSmVSWFNFMjdkOVY2QnZF?=
 =?utf-8?B?Wjl6cFFUTXdtdXhERXpXbFlCM1FLTnVoV21DcVNucG5iTnNsaTBpUzVuNUdx?=
 =?utf-8?B?eCt0dmk1RVN6ZmZMMDFmcWNIOTJrWEtwREZWSFlmQVd2UnQ4WjQxeEJjUHlp?=
 =?utf-8?B?cHpuREFTN0RGRkNsNzVJZmtoQlRWUW5FRmFGS0tVUVdOeVNrbmcxT2I5NVQ2?=
 =?utf-8?Q?88m1vPl8pQLtbT+JPrcFhfo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5e3664-e66e-4423-a6f2-08d9f845e7c8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 10:02:17.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdrQuJoy1mEcqb4otO/nNQKE7j6AxyRFpL7ZdKK/RsBFDqBLf2mC0snCnaJl28JVpxg+pHiLV+osCNEwgif3YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3618
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Souptick,

On 2/25/2022 13:16, Souptick Joarder wrote:
> On Thu, Feb 24, 2022 at 3:18 PM Yujie Liu <yujie.liu@intel.com> wrote:
>>
>> Souptick, could you help to provide the original report by link or attachment?
> 
> https://marc.info/?l=linux-mm&m=164487037605771&w=2
> 

this link is a notification mail of build status, but not a formal report,
so there may be many false alerts in this mail, please ignore them.

Thanks,
Yujie
