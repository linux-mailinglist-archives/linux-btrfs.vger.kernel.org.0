Return-Path: <linux-btrfs+bounces-1896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 522C18406B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 14:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBA0B24C2E
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B674C64CC1;
	Mon, 29 Jan 2024 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJ0l35SH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4600633FF;
	Mon, 29 Jan 2024 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534416; cv=fail; b=dFHEqzz9qPY1FOzbrzDs6n2T5CRWHM5lm/nNmrKbeCQwFDMyIJRZ/QFaYIk+S5IYxBy9yiqfuUzr8FSuiM9JxH7iCDhPIr9pEBgRRuJoEGyF/ucS3zG5sz1ZRAj5Peq7HiIzo3h/adiG2ycs7K4eHaZNgYxsgathVPVoYkUvhEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534416; c=relaxed/simple;
	bh=l+eLOH8Bu/YtHLPWC4jZSpiCp5JhuRp9WSWWzfpx9Lo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=aWTLrvrhk1HV58hVkS2JJH+4Fol+x5I1aUstFIu/gu2GvRQfJh1b8eRgVII3xmu4siKhsTdjNSrfzH/SQxm/F8s88/NK9rrGw3F8jL0sEFWTNOeKFFUtoZInoqd09vqc+VOZbnIFHCIYoz/LKsBTyvEo1JUUExBFYmdArhmEDkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJ0l35SH; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706534414; x=1738070414;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=l+eLOH8Bu/YtHLPWC4jZSpiCp5JhuRp9WSWWzfpx9Lo=;
  b=FJ0l35SH1hjJPBbXNlatOFqJUld6XJMfY7Fm7XqiRxysbgs1YAiirS3N
   qVv41EOEO8C/dCEt0jv77/LAVxXnkuXyA34VVfbgKQHP+/zzStfL/5xYy
   ol8xjSZ/tdf9Vi+DtYdFHROl1+HPyRmHnX0yJnNZJQMVsCZdLUMSfOhsg
   C/HQlShJxiKHuryRD8vTc1IWCllNM/0EZ5FdWRqIDFnNEGENlZNqjFluZ
   dPQIZ57E69lVNzF29Mhl5sxC5NQN2ZU01XXdXKa9mvcCQ//HgpSJ5qqqf
   eL//IOwwYTI/ya3saY1Ld6JEmTorJeASyeF/OW69mKZhXpuAmKERQDkPY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2836376"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2836376"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:20:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="960889231"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="960889231"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 05:20:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 05:20:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 05:20:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 05:20:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIkDwjXdXTUcdM5UdfPrDeGMrZMspkF3r76Vj58FRnfQORS7iIS223Z/1ghgHruYMIiT1cTTigAkEEGG5cT5e8q4Z3Kp71IpkA72d4FDh2r4SqM8Ks0tw2ekjopn1bqriNZUaWx7JcVurqvVW/S7qyGQSgxRjye7qEKxAcCnu4bP8K3Xa0buGDsKs11/oXBHe9uSXj4Ix2y8BZjnNXssX05f8yb9fsor3FMFRKLLyI8uxsAwnGCxT+Gvc/MCNDWO8paoGZ4oviLIXSK2ZL7L8n72mAWlFvYH1/hOGf928G0GnfN17B4gBNbo5sb2nKnVohl3WujcdJa/5GQdjeMjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7wKsb2m7i1UToTJ/r0EkrsfS/TXhQAZM9rdAopkBjk=;
 b=FIdVfGhg+fBlY210z2VnIuwQDxqlRYjv7Dq/cc2tUe/7whx+bJmYJw7CDgAjhZQXLkH79dSU/5NtE34ffJ1hPBcCdlNlpZ81M5z2eqWwmAFxUf90lhoM1QGOUiDxAlZhpWHOjp2PhYH70G1viSukfP5MVOw4QirVfhKseOpYt3BXXQe1tCkpunth3rmtn2HTQXr/3x8wtacuYQ+V5lPE603YlqTU/k41eYjjeMiabIZUUpz3ELgd7DpiW9/n8DUv0jxWQUebvDuKKJFtQMh6I79FoLABe/5ktt71/UhjerjOT38cvuGoRW4aIoWCjwTD3CTNP2MwHDFdJrm26UfAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 13:20:08 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 13:20:08 +0000
Date: Mon, 29 Jan 2024 21:19:59 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Filipe Manana <fdmanana@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	<linux-btrfs@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  3ee56a58ad:  stress-ng.ioprio.ops_per_sec
 2.5% improvement
Message-ID: <202401291605.e2a21f01-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7f3b9d-50e7-4a7b-2ee1-08dc20cd03ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPRNS0e4fk6YllrgEa/w1MiYXw8X84yvO3+jRXdTj9XN5kRb8QqxijjD7upvZLpP/E8i9MbJPsVkkYfEF9SXZfiOif1bTedwfTSNCWStL6hdLVM1SLbIIIBh472TS0G3AUYQwZeIiw7hXyRCKydd97HPYPjhLITDRhagSZPd7cnxtaPaBTseEYLR87LVYa0doi1FnsTcgwHAWyNxoiu/C2yhrjb2mfQ3t/JyXkMUWIIGAXOcA0EwdyJYy+VjdnYTYLx2Lyu/POZ85RuEJ55uIM+a7dPPsfNo/gnTElMTimoXUZAHYzgM345HzA0/6AoDTsNH66VWzlCL5dxSrmwmQ+GHZX3ebBZGfP33xluaDX/wguD48HyBrCWWaViLGn7GZFYdTJ/Yi6Mtl0sGrHS9rBCArz6xfPiICKVG3gmA0733EZUKPPxr95ezSeIOCNteR8dhKac5b5zBxiFyue5pp/jo1tN8BQsmuBfZkqtgxUTHO95rz8I7sv8/efEThSr5DAGyP+nZW0Mo/TKKkO4fvpGG6Q5Gp6Tu+OnjUxchUQJtOFeFqprUAQThVUqgq/LXHSDVmVbUO0tn+JxQDNkuGogsI+qKN+FtP6scwspZH0hSxe4Wkmjc22+GNkdLqAUi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(230473577357003)(230373577357003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(1076003)(107886003)(2616005)(6506007)(8676002)(26005)(5660300002)(8936002)(6512007)(4326008)(54906003)(66476007)(6916009)(316002)(66946007)(66556008)(966005)(6666004)(478600001)(86362001)(6486002)(82960400001)(38100700002)(41300700001)(36756003)(30864003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FIhsj4zAQH1boZdlG1L2Fjh+bFPoIWfV/I0GhLWVg5LCmGuyX9xKUn284g?=
 =?iso-8859-1?Q?+Eih7tHOyjwztlBPbPF5a83PzgM4nk4erEQOjocteWjABlmorfrCJIQzKo?=
 =?iso-8859-1?Q?Fe5Mh2H67K/f6PvHSQNq+t6EYBtYAr2ik/eSN25eU3crpvrqnYcKkJr+Zf?=
 =?iso-8859-1?Q?SBeE/rQ8HeUvz7GJvzKpartizcfgQRnhayDRy6UL2bOeOcWOMaM9Zg/2ne?=
 =?iso-8859-1?Q?EB9iG2g4+TyfMxVYuL802JEIyQq9DpAJjkdOCgMPw3Vfbkuj9Xqi2Pd5v/?=
 =?iso-8859-1?Q?AaMFDVrLxTqEEr5iOzJMyMriLyvCUCGxnIiXpWHflj1iVMHekqrHOjk4Xm?=
 =?iso-8859-1?Q?YC+ghscx4AaXVIKNVJHT2yHEccAGelfZruFnfp9p73F+6y8RNW1Z3wUzFF?=
 =?iso-8859-1?Q?jzVFI++qmly3jXiGplDaDoNUzzekQcgU//jH4dpAUxBow+7L9H7HuhlDir?=
 =?iso-8859-1?Q?bGbhizhaaxz6qMNVnwX+utW7jCTefCoZoPGcYXSWHkoPKV1qwon5st1Hqe?=
 =?iso-8859-1?Q?mpJc8o89eOTByITLgz86mTlOJNa9jCDKv0X/phVt3xb9LWAinSNGglc62u?=
 =?iso-8859-1?Q?imyLWtjKtug92c0J8AYxEFJ9NWMDyZ2iVsIqXs5jgBPr7LYmLr1zWsb4Me?=
 =?iso-8859-1?Q?4JJqr5JQ3plq6nFEVHKtPlfmUfOAnseq5vF8jqp9FEIYbRYgJcxy3FBu8i?=
 =?iso-8859-1?Q?l5BncB0YehcRhI1LZcaXt3S53RaynXtRkyG0JGY3KdZe05zTVqplqx+EYb?=
 =?iso-8859-1?Q?fuA8iUPxkIOH8TwJ/4b671eIaqrktqh9tjEDfuJ7AbeLOIHbhJ5lFLslyZ?=
 =?iso-8859-1?Q?FA9r/VgnnERt5V8Y8B/W65STlKarBZgQk2GwDmnfgkQiR39qVlX2Mzv/1+?=
 =?iso-8859-1?Q?9TQfpTA0MeiRqwbpUnrTPIFxQxOkE6j1pF7C5ihklUsWRNowZ0yPohJHQy?=
 =?iso-8859-1?Q?AQj143TAmVF6/W8MMDjlxCfNywWAeKfGXmxMffB0KNwMBE/XJWu5E3kBoc?=
 =?iso-8859-1?Q?+fIDSAX0tCmQKQ4OKSgjha3IIfM+P6tWe/d1G0xrqRXKxuagiFW2Iz9Z0+?=
 =?iso-8859-1?Q?r1fAsp9E51y0cGnhA7prKcE6BPXqOMgBB1YroHbxpGq1f7Op11QEAQGhhA?=
 =?iso-8859-1?Q?tiEk8ooOfptBMqUoJTqA4oUT/cn1R52I4UUcNiVl5BrnUShL6A1y5OmFoh?=
 =?iso-8859-1?Q?VBuO0+wSI+yW41Tce92Htmv8R/StIc/CQTJfgcja1hGC8NuZ/Oj3xZcQoS?=
 =?iso-8859-1?Q?6J9a2Y0y9veOFwiXT4j3wu+kKS2CXoYnu+6IVf0L1rNUc36JSO/zhFPQ+l?=
 =?iso-8859-1?Q?buu9G7LfPfPTkY3YzGD857P4x4QY5JFH9Fc2PeMHquEomOSqsTFPOVqOeh?=
 =?iso-8859-1?Q?Bg+umD5+m/B9pbPF2khFgVeUaLUbGsGnhnty9SBp7Oj+d4A624lEHYpFHB?=
 =?iso-8859-1?Q?CGu39ukR1rnyPRaX/XD9TcsCQCsS3T6inYpLgwMfIcD0tPKB3lwCluuV3i?=
 =?iso-8859-1?Q?+xzEaVT0gXpc/v2j4o8i6TvtOBQtU7/mpXBQQPJLx4ZEODYOa/r8/bLInK?=
 =?iso-8859-1?Q?ZAIAJ7INXN0JgGcD2BriFwHmdbCQ0SncmvKoEd7bbkc3KOodB0ws0g/3Hw?=
 =?iso-8859-1?Q?3IE9rhba3zE8ngIo7x6WjaW/x0zZcCU7GWN8/o/XEteOzS1iFdB4MjQQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7f3b9d-50e7-4a7b-2ee1-08dc20cd03ac
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 13:20:08.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyvOGgPuHyqZ9czcBAduaxVvxGQGgweYNyzSB2Ar2mrMX0XcsJdpGRfjDHlzX6uBGSfeiVLEdowmGdFXS1BqXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6864
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 2.5% improvement of stress-ng.ioprio.ops_per_sec on:


commit: 3ee56a58ad8921cb43c49d56347a8e270871844c ("btrfs: reserve space for delayed refs on a per ref basis")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
parameters:

	nr_threads: 10%
	disk: 1SSD
	testtime: 60s
	fs: btrfs
	class: filesystem
	test: ioprio
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240129/202401291605.e2a21f01-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1SSD/btrfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/ioprio/stress-ng/60s

commit: 
  8a526c44da ("btrfs: allow to run delayed refs by bytes to be released instead of count")
  3ee56a58ad ("btrfs: reserve space for delayed refs on a per ref basis")

8a526c44daeeb14d 3ee56a58ad8921cb43c49d56347 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      6.38            -0.9        5.47        mpstat.cpu.all.sys%
      1.98            +6.0%       2.10        iostat.cpu.iowait
      7.49           -11.7%       6.61        iostat.cpu.system
     89.17 ± 13%     -32.1%      60.50 ±  8%  perf-c2c.DRAM.local
      1329 ±  7%     -46.5%     711.00 ±  9%  perf-c2c.HITM.local
      8.10            -0.2        7.89        turbostat.C1%
     90.94            -2.6%      88.60        turbostat.PkgWatt
    268301            +2.4%     274788        vmstat.io.bo
      2.99 ±  3%     -10.0%       2.69 ±  5%  vmstat.procs.r
    245695            +2.5%     251795        stress-ng.ioprio.ops
      4091            +2.5%       4195        stress-ng.ioprio.ops_per_sec
  35380593            +2.5%   36258846        stress-ng.time.file_system_outputs
   8850082            +2.4%    9060525        stress-ng.time.voluntary_context_switches
    843089           -10.3%     756583        meminfo.Active
    183786           -41.8%     106965        meminfo.Active(file)
      4525 ±  2%     +34.8%       6099 ±  4%  meminfo.Dirty
      2653           -25.7%       1971 ±  2%  meminfo.Inactive(file)
    105571           +98.3%     209340 ±  3%  meminfo.SUnreclaim
    185785           +55.7%     289355 ±  2%  meminfo.Slab
    164826            -1.5%     162405        proc-vmstat.nr_active_anon
     45948           -41.8%      26741        proc-vmstat.nr_active_file
   4474369            +1.5%    4540982        proc-vmstat.nr_dirtied
      1132 ±  2%     +34.6%       1524 ±  4%  proc-vmstat.nr_dirty
    961239            -2.3%     939404        proc-vmstat.nr_file_pages
    663.31           -25.7%     492.53 ±  2%  proc-vmstat.nr_inactive_file
    191436            -1.3%     188994        proc-vmstat.nr_shmem
     26391           +98.3%      52335 ±  3%  proc-vmstat.nr_slab_unreclaimable
   4426700            +2.4%    4533828        proc-vmstat.nr_written
    164826            -1.5%     162405        proc-vmstat.nr_zone_active_anon
     45948           -41.8%      26741        proc-vmstat.nr_zone_active_file
    663.31           -25.7%     492.53 ±  2%  proc-vmstat.nr_zone_inactive_file
      1018 ±  2%     +40.4%       1429 ±  5%  proc-vmstat.nr_zone_write_pending
    600157           +10.7%     664147        proc-vmstat.numa_hit
    600112           +10.8%     664996 ±  2%  proc-vmstat.numa_local
    288285            -3.6%     277777        proc-vmstat.pgactivate
    632854            +9.4%     692643        proc-vmstat.pgalloc_normal
    256963            -1.2%     253938        proc-vmstat.pgfault
    299646           +19.3%     357624        proc-vmstat.pgfree
  17707875            +2.4%   18136034        proc-vmstat.pgpgout
      0.00 ± 31%    +157.1%       0.00 ± 33%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      1.17 ±158%     -99.4%       0.01 ± 15%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.16 ± 38%     -59.6%       0.47 ± 70%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  2%     -14.3%       0.01        perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.04 ±  4%     +48.8%       0.05 ± 37%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
     12.12 ±  8%    +582.6%      82.71 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     42.67 ±  8%     -71.1%      12.33 ± 10%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     96010 ±  2%     -60.7%      37739 ±  3%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
    392.17 ±  7%     -85.3%      57.67 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      7.77 ±107%   +2291.4%     185.72 ±196%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    596.01 ± 14%     +57.1%     936.17        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space
      0.01 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_alloc_path.btrfs_del_csums.do_free_extent_accounting.__btrfs_free_extent
      0.01 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space
      0.01 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.constprop
      0.01 ± 30%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.btrfs_search_slot.btrfs_del_csums.do_free_extent_accounting.__btrfs_free_extent
      0.05 ± 83%     -70.5%       0.01 ± 39%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_lookup_file_extent
      0.14 ±184%     -86.7%       0.02 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_extent_state.__set_extent_bit.set_extent_bit
      0.01 ±  3%     -20.0%       0.01 ±  5%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.03 ±  5%     +52.6%       0.05 ± 39%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.01 ± 31%   +2489.4%       0.37 ±143%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
     12.11 ±  8%    +582.9%      82.71 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 30%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space
      0.01 ± 32%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_alloc_path.btrfs_del_csums.do_free_extent_accounting.__btrfs_free_extent
      0.01 ± 37%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space
      0.01 ± 22%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.constprop
      0.01 ± 33%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.btrfs_search_slot.btrfs_del_csums.do_free_extent_accounting.__btrfs_free_extent
      7.77 ±107%   +2291.4%     185.72 ±196%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    596.00 ± 14%     +57.1%     936.17        perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.59           +22.7%       0.72        perf-stat.i.MPKI
  2.19e+09           -13.2%    1.9e+09        perf-stat.i.branch-instructions
      1.41            +0.1        1.53        perf-stat.i.branch-miss-rate%
  31632047            -5.8%   29805505        perf-stat.i.branch-misses
      7.97            +0.4        8.37        perf-stat.i.cache-miss-rate%
 1.005e+08            -5.3%   95210219        perf-stat.i.cache-references
      1.37           +12.6%       1.54        perf-stat.i.cpi
 1.678e+10            -7.3%  1.556e+10        perf-stat.i.cpu-cycles
    199.09 ±  6%     -13.7%     171.86 ±  8%  perf-stat.i.cpu-migrations
      2489            -9.3%       2257        perf-stat.i.cycles-between-cache-misses
      0.02 ±  4%      +0.0        0.02 ±  5%  perf-stat.i.dTLB-load-miss-rate%
 3.227e+09           -16.0%  2.712e+09        perf-stat.i.dTLB-loads
      0.00 ± 15%      +0.0        0.00 ±  4%  perf-stat.i.dTLB-store-miss-rate%
 1.842e+09           -16.2%  1.544e+09        perf-stat.i.dTLB-stores
  18277091            -2.6%   17800517        perf-stat.i.iTLB-loads
 1.237e+10           -15.9%   1.04e+10        perf-stat.i.instructions
     24577 ±  4%     -17.5%      20281 ±  5%  perf-stat.i.instructions-per-iTLB-miss
      0.74            -9.8%       0.67        perf-stat.i.ipc
      0.47            -7.3%       0.43        perf-stat.i.metric.GHz
    204.42           -15.1%     173.60        perf-stat.i.metric.M/sec
      0.62           +18.9%       0.73        perf-stat.overall.MPKI
      1.44            +0.1        1.57        perf-stat.overall.branch-miss-rate%
      7.58            +0.4        8.00        perf-stat.overall.cache-miss-rate%
      1.36           +10.2%       1.50        perf-stat.overall.cpi
      2203            -7.3%       2042        perf-stat.overall.cycles-between-cache-misses
      0.02 ±  4%      +0.0        0.02 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
     23659 ±  4%     -17.9%      19431 ±  5%  perf-stat.overall.instructions-per-iTLB-miss
      0.74            -9.2%       0.67        perf-stat.overall.ipc
 2.156e+09           -13.2%   1.87e+09        perf-stat.ps.branch-instructions
  31139709            -5.8%   29339631        perf-stat.ps.branch-misses
  98906589            -5.3%   93701518        perf-stat.ps.cache-references
 1.652e+10            -7.3%  1.531e+10        perf-stat.ps.cpu-cycles
    195.94 ±  6%     -13.7%     169.14 ±  8%  perf-stat.ps.cpu-migrations
 3.176e+09           -16.0%  2.669e+09        perf-stat.ps.dTLB-loads
 1.813e+09           -16.2%   1.52e+09        perf-stat.ps.dTLB-stores
  17986938            -2.6%   17517813        perf-stat.ps.iTLB-loads
 1.217e+10           -15.9%  1.024e+10        perf-stat.ps.instructions
 7.688e+11           -15.9%  6.467e+11        perf-stat.total.instructions
     23.72 ±  3%      -7.3       16.42 ±  3%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     23.11 ±  2%      -7.3       15.82 ±  3%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      8.12 ±  2%      -6.1        2.07 ± 16%  perf-profile.calltrace.cycles-pp.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread.kthread.ret_from_fork
      8.12 ±  2%      -6.1        2.07 ± 16%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread
      8.12 ±  2%      -6.1        2.07 ± 16%  perf-profile.calltrace.cycles-pp.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work.worker_thread.kthread
      8.12 ±  2%      -6.0        2.07 ± 16%  perf-profile.calltrace.cycles-pp.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space.process_one_work
      5.60 ±  2%      -4.5        1.13 ± 19%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space
      5.43 ±  2%      -4.4        1.06 ± 20%  perf-profile.calltrace.cycles-pp.run_delayed_data_ref.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space
      4.30 ±  3%      -3.4        0.90 ± 24%  perf-profile.calltrace.cycles-pp.__btrfs_free_extent.run_delayed_data_ref.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs
      2.80 ±  4%      -2.4        0.37 ±100%  perf-profile.calltrace.cycles-pp.do_free_extent_accounting.__btrfs_free_extent.run_delayed_data_ref.btrfs_run_delayed_refs_for_head.__btrfs_run_delayed_refs
      2.50 ±  4%      -2.2        0.33 ±100%  perf-profile.calltrace.cycles-pp.btrfs_del_csums.do_free_extent_accounting.__btrfs_free_extent.run_delayed_data_ref.btrfs_run_delayed_refs_for_head
      3.94 ±  6%      -1.6        2.34 ± 11%  perf-profile.calltrace.cycles-pp.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread
      2.34 ±  8%      -1.6        0.76 ± 30%  perf-profile.calltrace.cycles-pp.btrfs_extend_item.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
      2.33 ±  2%      -1.5        0.79 ± 48%  perf-profile.calltrace.cycles-pp.cleanup_ref_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space.btrfs_preempt_reclaim_metadata_space
     14.78 ±  3%      -1.2       13.54 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread.kthread
     14.81 ±  3%      -1.2       13.56 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
      1.65            -1.0        0.63 ± 48%  perf-profile.calltrace.cycles-pp.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.flush_space
      0.77 ±  8%      -0.1        0.68 ±  8%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.83 ±  4%      +0.1        0.90 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_csum.btrfs_csum_file_blocks.btrfs_finish_one_ordered.btrfs_work_helper
      0.88 ±  5%      +0.2        1.13 ±  3%  perf-profile.calltrace.cycles-pp.btrfs_add_delayed_data_ref.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      0.00            +0.5        0.55 ±  3%  perf-profile.calltrace.cycles-pp.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head
      0.00            +0.5        0.55 ±  3%  perf-profile.calltrace.cycles-pp.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_del_csums
      0.00            +0.6        0.60 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_lock_root_node.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.00            +0.6        0.64 ±  5%  perf-profile.calltrace.cycles-pp.__memmove.__write_extent_buffer.memmove_extent_buffer.btrfs_truncate_item.truncate_one_csum
      0.00            +0.7        0.74 ±  5%  perf-profile.calltrace.cycles-pp.__write_extent_buffer.memmove_extent_buffer.btrfs_truncate_item.truncate_one_csum.btrfs_del_csums
      0.00            +0.8        0.82 ±  5%  perf-profile.calltrace.cycles-pp.memmove_extent_buffer.btrfs_truncate_item.truncate_one_csum.btrfs_del_csums.cleanup_ref_head
     23.75 ±  3%      +1.6       25.30 ±  3%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     23.75 ±  3%      +1.6       25.30 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     23.75 ±  3%      +1.6       25.30 ±  3%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.64 ±  5%      +2.1        2.70 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs
      0.00            +2.2        2.20 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.btrfs_start_dirty_block_groups
      0.57 ±  4%      +2.2        2.77 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_truncate_item.truncate_one_csum.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs
      0.63 ±  3%      +2.4        3.00 ±  6%  perf-profile.calltrace.cycles-pp.truncate_one_csum.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs
      0.00            +2.5        2.54 ±  8%  perf-profile.calltrace.cycles-pp.cleanup_ref_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.btrfs_start_dirty_block_groups.btrfs_commit_transaction
      0.00            +2.7        2.68 ±  8%  perf-profile.calltrace.cycles-pp.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.btrfs_start_dirty_block_groups.btrfs_commit_transaction.transaction_kthread
      0.00            +2.7        2.68 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs.btrfs_start_dirty_block_groups.btrfs_commit_transaction.transaction_kthread.kthread
      0.00            +2.7        2.68 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_start_dirty_block_groups.btrfs_commit_transaction.transaction_kthread.kthread.ret_from_fork
      0.00            +4.8        4.76 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_del_csums.cleanup_ref_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.btrfs_commit_transaction
      0.00            +5.7        5.66 ±  4%  perf-profile.calltrace.cycles-pp.cleanup_ref_head.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.btrfs_commit_transaction.transaction_kthread
      0.00            +6.1        6.11 ±  5%  perf-profile.calltrace.cycles-pp.__btrfs_run_delayed_refs.btrfs_run_delayed_refs.btrfs_commit_transaction.transaction_kthread.kthread
      0.00            +6.1        6.12 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_run_delayed_refs.btrfs_commit_transaction.transaction_kthread.kthread.ret_from_fork
      0.00            +8.9        8.85 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.transaction_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +8.9        8.85 ±  6%  perf-profile.calltrace.cycles-pp.transaction_kthread.kthread.ret_from_fork.ret_from_fork_asm
     23.72 ±  3%      -7.3       16.42 ±  3%  perf-profile.children.cycles-pp.worker_thread
     23.11 ±  2%      -7.3       15.82 ±  3%  perf-profile.children.cycles-pp.process_one_work
      8.12 ±  2%      -6.1        2.07 ± 16%  perf-profile.children.cycles-pp.btrfs_preempt_reclaim_metadata_space
      8.12 ±  2%      -6.1        2.07 ± 16%  perf-profile.children.cycles-pp.flush_space
      5.61 ±  2%      -4.4        1.23 ± 18%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs_for_head
      5.43 ±  2%      -4.3        1.14 ± 19%  perf-profile.children.cycles-pp.run_delayed_data_ref
      4.31 ±  3%      -3.4        0.95 ± 23%  perf-profile.children.cycles-pp.__btrfs_free_extent
      2.80 ±  4%      -2.2        0.62 ± 24%  perf-profile.children.cycles-pp.do_free_extent_accounting
      2.51 ±  9%      -1.7        0.82 ± 31%  perf-profile.children.cycles-pp.btrfs_extend_item
      3.94 ±  6%      -1.6        2.34 ± 11%  perf-profile.children.cycles-pp.btrfs_csum_file_blocks
      4.86 ±  2%      -1.6        3.27 ±  3%  perf-profile.children.cycles-pp.btrfs_del_items
      4.12 ±  4%      -1.4        2.69 ±  6%  perf-profile.children.cycles-pp.btrfs_get_token_32
     14.81 ±  3%      -1.2       13.56 ±  2%  perf-profile.children.cycles-pp.btrfs_work_helper
     14.78 ±  3%      -1.2       13.54 ±  2%  perf-profile.children.cycles-pp.btrfs_finish_one_ordered
      3.38 ±  4%      -1.0        2.42 ±  5%  perf-profile.children.cycles-pp.btrfs_set_token_32
      1.02 ±  4%      -0.9        0.17 ± 18%  perf-profile.children.cycles-pp.alloc_reserved_file_extent
      1.05 ±  5%      -0.8        0.24 ± 18%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      2.95 ±  2%      -0.7        2.29 ±  4%  perf-profile.children.cycles-pp.setup_items_for_insert
      0.35 ±  5%      -0.3        0.08 ± 22%  perf-profile.children.cycles-pp.btrfs_update_block_group
      0.64 ±  7%      -0.2        0.40 ± 13%  perf-profile.children.cycles-pp.memcpy_extent_buffer
      0.25 ±  4%      -0.2        0.03 ±106%  perf-profile.children.cycles-pp.lookup_extent_backref
      0.25 ±  5%      -0.2        0.03 ±106%  perf-profile.children.cycles-pp.lookup_inline_extent_backref
      1.14 ±  6%      -0.1        1.04 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.85 ±  5%      -0.1        0.75 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.24 ±  5%      -0.1        0.16 ± 16%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.40 ±  6%      -0.1        0.32 ± 15%  perf-profile.children.cycles-pp.clock_nanosleep
      0.14 ±  9%      -0.1        0.07 ± 16%  perf-profile.children.cycles-pp.work_busy
      0.12 ± 19%      -0.1        0.06 ± 19%  perf-profile.children.cycles-pp.btrfs_delayed_refs_rsv_refill
      0.24 ±  7%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.extent_clear_unlock_delalloc
      0.08 ± 16%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.sbitmap_find_bit
      0.08 ± 11%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.assert_eb_page_uptodate
      0.08 ± 14%      +0.0        0.12 ± 14%  perf-profile.children.cycles-pp.rb_next
      0.13 ±  9%      +0.0        0.17 ±  7%  perf-profile.children.cycles-pp.btrfs_get_64
      0.07 ± 14%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.btrfs_mark_buffer_dirty
      0.04 ± 71%      +0.0        0.08 ± 10%  perf-profile.children.cycles-pp.need_preemptive_reclaim
      0.14 ±  5%      +0.0        0.19 ± 12%  perf-profile.children.cycles-pp.btrfs_global_root
      0.01 ±223%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.btrfs_buffer_uptodate
      0.02 ±141%      +0.1        0.07 ± 24%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.02 ±141%      +0.1        0.07 ± 14%  perf-profile.children.cycles-pp.btrfs_verify_level_key
      0.34 ±  7%      +0.1        0.40 ± 10%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.07 ± 18%      +0.1        0.12 ± 13%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.btrfs_delayed_ref_lock
      0.08 ± 14%      +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.up_read
      0.27 ±  6%      +0.1        0.34 ±  6%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.01 ±223%      +0.1        0.08 ±  7%  perf-profile.children.cycles-pp.update_existing_head_ref
      0.11 ±  9%      +0.1        0.18 ± 13%  perf-profile.children.cycles-pp.wake_up_q
      0.11 ±  9%      +0.1        0.18 ±  8%  perf-profile.children.cycles-pp.release_extent_buffer
      0.17 ±  6%      +0.1        0.25 ±  6%  perf-profile.children.cycles-pp.rb_erase
      0.07 ± 17%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.merge_state
      0.13 ±  8%      +0.1        0.22 ± 10%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.38 ±  4%      +0.1        0.48 ±  6%  perf-profile.children.cycles-pp.find_extent_buffer_nolock
      0.06 ±  7%      +0.1        0.16 ± 15%  perf-profile.children.cycles-pp.btrfs_select_ref_head
      0.20 ± 12%      +0.1        0.29 ±  9%  perf-profile.children.cycles-pp.read_extent_buffer
      0.10 ± 10%      +0.1        0.20 ± 11%  perf-profile.children.cycles-pp.btrfs_delete_ref_head
      0.00            +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.find_ref_head
      0.10 ±  6%      +0.1        0.21 ± 11%  perf-profile.children.cycles-pp.btrfs_csum_root
      0.26 ± 10%      +0.1        0.38 ±  9%  perf-profile.children.cycles-pp.btrfs_root_node
      0.27 ±  4%      +0.1        0.39 ±  8%  perf-profile.children.cycles-pp.btrfs_free_path
      0.21 ± 13%      +0.1        0.34 ± 13%  perf-profile.children.cycles-pp.free_extent_buffer
      0.17 ±  6%      +0.1        0.29 ± 11%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      0.34 ±  5%      +0.1        0.47 ±  5%  perf-profile.children.cycles-pp.down_read
      0.17 ±  8%      +0.1        0.30 ±  8%  perf-profile.children.cycles-pp.set_extent_buffer_dirty
      0.18 ±  2%      +0.1        0.32 ± 11%  perf-profile.children.cycles-pp.rwsem_wake
      0.48 ±  4%      +0.1        0.62 ±  7%  perf-profile.children.cycles-pp.block_group_cache_tree_search
      0.48 ±  4%      +0.2        0.65 ±  7%  perf-profile.children.cycles-pp.find_extent_buffer
      0.24 ±  7%      +0.2        0.42 ±  7%  perf-profile.children.cycles-pp.__btrfs_tree_read_lock
      0.34 ±  3%      +0.2        0.53 ±  5%  perf-profile.children.cycles-pp.up_write
      0.64 ±  3%      +0.2        0.84 ±  5%  perf-profile.children.cycles-pp.btrfs_bin_search
      0.14 ± 13%      +0.2        0.36 ±  7%  perf-profile.children.cycles-pp.insert_delayed_ref
      0.23 ±  6%      +0.2        0.48 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.48 ±  4%      +0.3        0.74 ±  6%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      1.63 ±  4%      +0.3        1.90 ±  2%  perf-profile.children.cycles-pp.btrfs_add_delayed_data_ref
      0.04 ± 75%      +0.3        0.32 ± 15%  perf-profile.children.cycles-pp.btrfs_set_item_key_safe
      0.14 ± 14%      +0.3        0.46 ±  7%  perf-profile.children.cycles-pp.pin_down_extent
      0.50 ±  4%      +0.4        0.86 ±  7%  perf-profile.children.cycles-pp.btrfs_release_path
      0.52 ±  3%      +0.4        0.90 ±  4%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.51 ±  3%      +0.4        0.89 ±  5%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.80 ±  4%      +0.4        1.18 ±  3%  perf-profile.children.cycles-pp.read_block_for_search
      3.63 ±  3%      +0.4        4.02 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock
      1.57 ±  3%      +0.4        1.99 ±  3%  perf-profile.children.cycles-pp.__memmove
      0.78 ±  4%      +0.4        1.23 ±  3%  perf-profile.children.cycles-pp.down_write
      0.63 ±  3%      +0.5        1.10 ±  4%  perf-profile.children.cycles-pp.__btrfs_tree_lock
      0.41 ±  4%      +0.6        1.04 ±  4%  perf-profile.children.cycles-pp.btrfs_lock_root_node
      2.05 ±  3%      +0.6        2.70 ±  3%  perf-profile.children.cycles-pp.__write_extent_buffer
      1.44 ±  3%      +0.8        2.19 ±  3%  perf-profile.children.cycles-pp.memmove_extent_buffer
     23.75 ±  3%      +1.6       25.30 ±  3%  perf-profile.children.cycles-pp.kthread
     23.75 ±  3%      +1.6       25.30 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
     23.75 ±  3%      +1.6       25.30 ±  3%  perf-profile.children.cycles-pp.ret_from_fork_asm
      3.34            +1.8        5.09 ±  3%  perf-profile.children.cycles-pp.btrfs_search_slot
      1.40 ±  3%      +2.1        3.46 ±  6%  perf-profile.children.cycles-pp.btrfs_truncate_item
      1.34 ±  3%      +2.1        3.48 ±  6%  perf-profile.children.cycles-pp.truncate_one_csum
      0.00            +2.7        2.68 ±  8%  perf-profile.children.cycles-pp.btrfs_start_dirty_block_groups
      8.12 ±  2%      +2.7       10.86 ±  6%  perf-profile.children.cycles-pp.__btrfs_run_delayed_refs
      8.12 ±  2%      +2.7       10.86 ±  6%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs
      4.15 ±  2%      +4.0        8.19 ±  5%  perf-profile.children.cycles-pp.btrfs_del_csums
      2.33 ±  2%      +6.8        9.08 ±  5%  perf-profile.children.cycles-pp.cleanup_ref_head
      0.00            +8.9        8.85 ±  6%  perf-profile.children.cycles-pp.btrfs_commit_transaction
      0.00            +8.9        8.85 ±  6%  perf-profile.children.cycles-pp.transaction_kthread
      3.80 ±  4%      -1.3        2.46 ±  6%  perf-profile.self.cycles-pp.btrfs_get_token_32
      2.97 ±  4%      -0.9        2.09 ±  5%  perf-profile.self.cycles-pp.btrfs_set_token_32
      0.73 ±  4%      -0.3        0.43 ±  7%  perf-profile.self.cycles-pp.btrfs_del_items
      0.44 ± 14%      -0.3        0.14 ± 27%  perf-profile.self.cycles-pp.btrfs_extend_item
      0.61 ±  5%      -0.1        0.46 ±  8%  perf-profile.self.cycles-pp.setup_items_for_insert
      0.22 ±  6%      -0.1        0.11 ± 22%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.13 ±  9%      -0.1        0.05 ± 74%  perf-profile.self.cycles-pp.btrfs_find_space_for_alloc
      0.08 ± 11%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.assert_eb_page_uptodate
      0.07 ± 14%      +0.0        0.10 ± 15%  perf-profile.self.cycles-pp.rb_next
      0.06 ±  6%      +0.0        0.09 ± 11%  perf-profile.self.cycles-pp.insert_delayed_ref
      0.12 ± 10%      +0.0        0.16 ±  9%  perf-profile.self.cycles-pp.btrfs_get_64
      0.07 ± 10%      +0.0        0.11 ± 12%  perf-profile.self.cycles-pp.btrfs_mark_buffer_dirty
      0.08 ± 13%      +0.0        0.12 ± 15%  perf-profile.self.cycles-pp.unlock_up
      0.10 ± 12%      +0.0        0.14 ± 14%  perf-profile.self.cycles-pp.free_extent_buffer
      0.16 ±  6%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.up_write
      0.05 ± 47%      +0.1        0.10 ± 13%  perf-profile.self.cycles-pp.rwsem_mark_wake
      0.31 ±  7%      +0.1        0.36 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free
      0.02 ±141%      +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.btrfs_delete_ref_head
      0.02 ±141%      +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.btrfs_verify_level_key
      0.10 ± 14%      +0.1        0.16 ± 10%  perf-profile.self.cycles-pp.memmove_extent_buffer
      0.40 ±  7%      +0.1        0.46 ±  8%  perf-profile.self.cycles-pp._raw_read_lock
      0.08 ± 12%      +0.1        0.13 ± 12%  perf-profile.self.cycles-pp.up_read
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.cleanup_ref_head
      0.04 ± 72%      +0.1        0.10 ±  8%  perf-profile.self.cycles-pp.btrfs_del_csums
      0.27 ±  6%      +0.1        0.33 ±  6%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.17 ±  6%      +0.1        0.24 ±  5%  perf-profile.self.cycles-pp.rb_erase
      0.10 ±  7%      +0.1        0.18 ± 11%  perf-profile.self.cycles-pp.release_extent_buffer
      0.11 ± 10%      +0.1        0.20 ±  6%  perf-profile.self.cycles-pp.read_block_for_search
      0.20 ± 12%      +0.1        0.28 ±  9%  perf-profile.self.cycles-pp.read_extent_buffer
      0.00            +0.1        0.10 ± 13%  perf-profile.self.cycles-pp.find_ref_head
      0.30 ±  3%      +0.1        0.42 ± 10%  perf-profile.self.cycles-pp.block_group_cache_tree_search
      0.26 ± 10%      +0.1        0.38 ±  8%  perf-profile.self.cycles-pp.btrfs_root_node
      0.15 ±  9%      +0.1        0.27 ±  9%  perf-profile.self.cycles-pp.set_extent_buffer_dirty
      0.40 ±  9%      +0.2        0.58 ±  4%  perf-profile.self.cycles-pp.__write_extent_buffer
      0.62 ±  3%      +0.2        0.82 ±  5%  perf-profile.self.cycles-pp.btrfs_bin_search
      0.22 ±  7%      +0.2        0.47 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.36 ±  5%      +0.3        0.61 ±  7%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.32 ±  3%      +0.3        0.59 ±  8%  perf-profile.self.cycles-pp.btrfs_truncate_item
      1.54 ±  3%      +0.4        1.96 ±  3%  perf-profile.self.cycles-pp.__memmove
      0.26 ±  5%      +0.5        0.72 ±  6%  perf-profile.self.cycles-pp.rwsem_optimistic_spin




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


