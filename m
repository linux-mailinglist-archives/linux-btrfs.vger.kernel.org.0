Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBA549DCA7
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 09:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiA0IhI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 03:37:08 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:55915 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231663AbiA0IhG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 03:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1643272624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AmE/yovtBFStupR5YFqd5n4UuSLlc2DmEO/7AZWairY=;
        b=PryXDyUJCq5J5OGk5CMHE9BUKcDpJfpISOemvkqKLzi0S2hJ2nwjCX24r308ZfIcf4awMF
        9G3uhwdS+uZpk0OEbZlXN4gI5n8UR4wBw00SawyFlNRdQecg//v3ZMCNR8wfpW+izeNIHA
        rC4NqZ7irQ7+E8h20u8xgcPOgECKMzg=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-VxZ3hfD8O42DUDf_uN-IOg-1; Thu, 27 Jan 2022 09:37:03 +0100
X-MC-Unique: VxZ3hfD8O42DUDf_uN-IOg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgkMEDBuIblFflDlMZ2A9yvCjwIk4NKj8gOLeSri9o5j+K+mQIgm54zvtsxUOyncU5rfPXiD2z6cwNPq9953z7N38RKJoSHXB+kDSbNtXJMvPu8kk9Q6V87f6EgTuw/2CGjPCDM1uWR1p70blH+AuLZC08lHV/Jwr3Fxp2gi+OOtjDG6OfuU2exg47G3juqGPLz3Jk4sTsNr3cJBnbEcVRfyxdiTDOQtelGPgB2QfJRup8b40cZhsSVmeQJeYgilcgEVVrwurPC4ohswCzLBEhlJrJU0MHeEQ9vzzWO3aXItelnRBWnza/kS7NdWebsir0+CzYMBD4eJE3yEEJTzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMUAbZEVvjqB+425Zk+fqYpdhY/Y4HVZXi3En19Fwx8=;
 b=PplTA4QFjJ2SY15bzidp7DzDWWa0QmFXjtozX23apWz8p0jJX8UOMyclwTyc9+ysPpf0WBHg2sMMMELwIFeOEz9y1hcXOQ6ORP8jlUHan8RxnMu72Ag2Nhuw07sTMfm0TPZbpjwn9bZEYRusdOy81yBlzrAZMUbq+8zuiWkdVfMA1siGDXv9bTvEUGbYMobMrWM/wKmnY5rO2P0B2PxsPKJXG8mKauwgMWkvt6O0o9j8QG6vGPobTotUH3vdctiTGmW1K9NrX4eFPvUf2GxCVRin+RJ7KUaUMw/YXEjdBhSsYusiQ1PpIQLoUk3LrGB3+vYEaABvngoxXkFgZh2ZUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DBAPR04MB7477.eurprd04.prod.outlook.com (2603:10a6:10:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 08:37:02 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e%5]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 08:37:02 +0000
Message-ID: <d90f3a26-1fb8-8079-ff51-a68a8141577a@suse.com>
Date:   Thu, 27 Jan 2022 16:36:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RFC] btrfs: sysfs: add <uuid>/debug/io_accounting/
 directory
Content-Language: en-US
To:     kernel test robot <yujie.liu@intel.com>
CC:     kbuild-all@lists.01.org,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <202201260130.4VVHtyiM-lkp@intel.com>
 <0e88a42c-ee0c-e962-e326-84d940769a96@intel.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <0e88a42c-ee0c-e962-e326-84d940769a96@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55d6bcf5-2a7e-4095-375d-08d9e17030c9
X-MS-TrafficTypeDiagnostic: DBAPR04MB7477:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB74776290EBE927175FA5E6A2D6219@DBAPR04MB7477.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grhDlPrHQNqzDpbA9FSWemDRf3RKVrmIEVhSvw50YwQWRiBqiSsopxBnvcTPjzF/sF1b+PM0vnn/cMY5wyW37silTp9S4V0+U5yPtJ+f9B1Iy+yCjjBF53BXLplN+tLR1+2zumN1Upj5B53iw933F7VrgdsfWr6NihHRFDaojLMIpOrKhHfjkd0s8Ex984Gauqu2UMIy3kJQh/pkk7y4DBZba4PTppLuTm/Ejq/GWBL9QCZ6RvZy/FcSRB83tghiedKIxlCwPEjW079knSVlU5rGLG0tnniDQfECK89NbdWgKwuYyExhZMzsoYT72CjOpYWxTsiMvIuGCUQYK/zF+7WHsxqOTDkLes3SqzCbhJW8Om3jNOODpNTNLuyNQp5D708jyW7TFR2xYwV8v+fRueygYBfULZxs4KIypS/hhvf+kMxFEgohoR7oN20Lb68ls6UwxNoFzkB3rxAO1QDwQntWiHB/B/gZIey9vc0IWd+IEMe8zNwTnnyk3dXd4T5PueSnqTxUx6hrP2xBkzrOq7v1On7Ju4Nqifs3GPR0izfFCgpan6tFn0waccqugIu6wKkaHgKxvf+ZFB58dCEStL17sPZoVawqXtx4OnZNnIYhNGjUZ5u3dFl162YPIPbMnFhzarJSr6Z/Y+sHawjiErYaouHUTIWGkz6JbfxEH9pTKL7feHlQuwIkPtdSiMQ75EIjZEzNr3UxAaTcQ4Bd4M9UIIstzVGGVRWy2jh9/5Sh8Z0u593VIjukBcSIhl7K4wLgy1PpbicO71w0cvdVmZZ/y+2MiYWxoazWI6/A9V2BT9XFAApyXajBQjvgaasa6aOgwckcLua700SchuHuCmge4os8DZC64dKY1ifniVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(31696002)(36756003)(8676002)(8936002)(6916009)(5660300002)(316002)(508600001)(966005)(4326008)(86362001)(6486002)(6666004)(26005)(186003)(31686004)(2616005)(38100700002)(83380400001)(2906002)(6512007)(53546011)(6506007)(4001150100001)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wIGxxtC0SFX5E4/JHNw9D2OnwDArmd5TMbUmQr1NxZ4DIno26HvhBkDAk11Q?=
 =?us-ascii?Q?eKUMUU5T4W3UEYX3z0hc82J+UZmTzhge4CpRzhF4nLYtVeU54nSRVwOoi9U9?=
 =?us-ascii?Q?Sfo72PTSHUcSmXDqyI9wycqb3xcKU/K4Nvisa7tiLojBaVkc5incmtzIRu6V?=
 =?us-ascii?Q?Cglwrv0ueSO+YbfTE/jKWZ8S9sV/NQouFBjCtixW8Yj9hk25GWhlG+yvt1xi?=
 =?us-ascii?Q?BvuYT8Ms0raWL46iDpKGEx43JpkZvmj5GRyEPpiHeOSKUKK3fouPkaOdURHK?=
 =?us-ascii?Q?9fXacAiE6WnIObhRy2ArI7xn6Y6yseiHOE9d+1AkNUe+9nAW65npq1vtm4j+?=
 =?us-ascii?Q?N+a/aWBOJGdpp7t3FawtTRDHHULEuz1cOO72yabyPIE14Wh9O2utJFrZHB4a?=
 =?us-ascii?Q?EgjwXEupr19+3vQxdyPCbA+6z6FffCY24mI8TB+G9Y5Rvkixr5vCgrdVMXfS?=
 =?us-ascii?Q?WuHwYeqzH9wnBRYLpxAl1fJagQW2/Fgn9eGQHGDghQdeYyfeRjmBF7R4eZj9?=
 =?us-ascii?Q?eDZloEn556R47T4FEPgRsQMdpbcpns5mz9PvvPWsJXQAh45WR2QXlpFyxpGL?=
 =?us-ascii?Q?G6+QC0txjv+7MrVCWS5c7bQFSoBd/RpacbuBRRhFBQ3n1u1BLIXqRvk/M3+c?=
 =?us-ascii?Q?VpYh602XpTvGqs8DqIIc4RqFGOGHNlXAV0ncLe6++BevXOnlV5orZ5GkfyvJ?=
 =?us-ascii?Q?LQxXRBT4nLZnAHlwUB6JVT1oEgnZuuwUve3TOf8n1LcUN7riZ+JSJiUMcHlN?=
 =?us-ascii?Q?+5KTlk98IAhnCpxdSJzHmfHdTXBHn75jiZwB3QGReAKWixuzQKMX5immggrr?=
 =?us-ascii?Q?ts6F1KOyg87pxFkcfIL5+8mLWxqX9WqM1+yb5TOYtS21cmCBoMo5Q9Uo/v+J?=
 =?us-ascii?Q?9hFv9aI2yeBcQWBUUxCMH9C/ekHsQZa/qmXZoOvMk8l8Kx/I1OSm2PUsEK0c?=
 =?us-ascii?Q?EjTBq/3Cn29NNpCXhsV4CIQ+9HSLY+crBuIHcfpK6NYBAae9YYKgsr2hIYOC?=
 =?us-ascii?Q?B8n+aBRm7zw4ZPIlRwIRdXTWrQPgj++noCxI+daZMn6VCAW/WABdRKb1xu0y?=
 =?us-ascii?Q?45kAP55nbK8daHLHmPv39yc6OK06XURJ4zFqNx/LtvdD1HwMRzwIqx5vioLO?=
 =?us-ascii?Q?2+DA+kbApOTpQBqG6PHrzv2orzvRX0ffEswPn4iJHYktYzuHUNcNi4RqWMnc?=
 =?us-ascii?Q?l4FrnmnNYu5ES2aPFt/en+ME6CTrPfaa9AJnbrnoj9jRzxmzdRk+EOWs2XI9?=
 =?us-ascii?Q?UrzMZam5i8mjwR6/TLwAROdlQKfcl13fLUfONK/SbRzpvtXzIghTNjq/0XIv?=
 =?us-ascii?Q?Q9ffHXS5w56r/CsPwPFpZJ/ZfooePb0HCmak32NzX5yHV9ZeiQan/f0ZPmtx?=
 =?us-ascii?Q?NpbkbglIwR1TuW/z/z8pjXeZmuCfY8NcZE/pA95+yR7h2s38r/AhN005LktZ?=
 =?us-ascii?Q?cKRfcyta2O32cubbMHVWJ4JJXAVTFuvYmFVqdVq8QppavOFWdbWFxd5doKnI?=
 =?us-ascii?Q?PnEqH5MI8bGW58EAj7npu712DwW/b1+MxGA7EfIRRFG/5pF/HSZhTWH5FqdR?=
 =?us-ascii?Q?UlFMm1C5pNA0aYY3yfE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d6bcf5-2a7e-4095-375d-08d9e17030c9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 08:37:02.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13Mja5LP71f53LyAtVOC1Og1e2xnRBS5fgS5TWenCBFYfedeb+jVj/l83JTsyaUn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7477
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/27 14:09, kernel test robot wrote:
> Hi Wenruo,
>=20
> [FYI, it's a private test report for your RFC patch.]
> [auto build test WARNING on kdave/for-next]
> [also build test WARNING on v5.17-rc1 next-20220125]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:   =20
> https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-sysfs-add-uuid-d=
ebug-io_accounting-directory/20220121-132629=20
>=20
> base:=C2=A0=C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/kdave/l=
inux.git=20
> for-next
> config: x86_64-randconfig-c007-20220124=20
> (https://download.01.org/0day-ci/archive/20220126/202201260130.4VVHtyiM-l=
kp@intel.com/config)=20
>=20
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project=20
> 997e128e2a78f5a5434fc75997441ae1ee76f8a4)
> reproduce (this is a W=3D1 build):
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wget=20
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross=
=20
> -O ~/bin/make.cross
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chmod +x ~/bin/make.cross
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #=20
> https://github.com/0day-ci/linux/commit/879aebce4c7d6a684b93b92545978dc75=
bf4abd5=20
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git remote add linux-review h=
ttps://github.com/0day-ci/linux
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git fetch --no-tags linux-rev=
iew=20
> Qu-Wenruo/btrfs-sysfs-add-uuid-debug-io_accounting-directory/20220121-132=
629=20
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git checkout 879aebce4c7d6a68=
4b93b92545978dc75bf4abd5
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # save the config file to lin=
ux build tree
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 COMPILER_INSTALL_PATH=3D$HOME=
/0day COMPILER=3Dclang make.cross=20
> ARCH=3Dx86_64 clang-analyzer
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
>=20
> clang-analyzer warnings: (new ones prefixed by >>)
>=20
>  >> fs/btrfs/volumes.c:6780:6: warning: Value stored to 'length' during=20
> its initialization is never read [clang-analyzer-deadcode.DeadStores]
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 length =
=3D bio->bi_iter.bi_size;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^~~~~~=C2=A0=C2=A0 ~~~~~~~~~~~~~~~~~~~~
>  >> fs/btrfs/volumes.c:6781:7: warning: Value stored to 'metadata'=20
> during its initialization is never read=20
> [clang-analyzer-deadcode.DeadStores]
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool metada=
ta =3D bio->bi_opf & REQ_META;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~~~~~~~=C2=A0=C2=A0 ~~~~~~~~~~~~~~~~~~~~~~
>=20
> vim +/length +6780 fs/btrfs/volumes.c
>=20
> de1ee92ac3bce4 Josef Bacik 2012-10-19=C2=A0 6777
> 879aebce4c7d6a Qu Wenruo=C2=A0=C2=A0 2022-01-21=C2=A0 6778=C2=A0 static v=
oid=20
> update_io_accounting(struct btrfs_fs_info *fs_info, struct bio *bio)
> 879aebce4c7d6a Qu Wenruo=C2=A0=C2=A0 2022-01-21=C2=A0 6779=C2=A0 {
> 879aebce4c7d6a Qu Wenruo=C2=A0=C2=A0 2022-01-21 @6780=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 u32 length =3D=20
> bio->bi_iter.bi_size;
> 879aebce4c7d6a Qu Wenruo=C2=A0=C2=A0 2022-01-21 @6781=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 bool metadata =3D=20
> bio->bi_opf & REQ_META;
> 879aebce4c7d6a Qu Wenruo=C2=A0=C2=A0 2022-01-21=C2=A0 6782
>=20
> ## this build has CONFIG_BTRFS_DEBUG=3Dn ##

No wonder, I'd put the initialization inside CONFIG_BTRFS_DEBUG branch.

Thanks for catching it.

Qu

>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>=20

