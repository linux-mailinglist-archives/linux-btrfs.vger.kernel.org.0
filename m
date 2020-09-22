Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975682740DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 13:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgIVLbd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 07:31:33 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:56877 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbgIVLbc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 07:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600774289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=36og92gMvRXME8XFKICpmCsNJ545Z6daSBUyr7TXya0=;
        b=lLv8+xH/yRP+QVaLBr4Gt/lFT2ghZUU71AnPWSU9evBk06McKBoczz7wJU7QlW7KZpuk3t
        m8Z/HmZpTphPhBJFOdV52KIdx5wmxN+MH9whsW5cc9leD342nlJdcbsBqEyIufwco8/SvH
        m7se7FJwxdnugTGQtddYgiP3qN1i2nA=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2057.outbound.protection.outlook.com [104.47.8.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-17-J1BA38EwMk-HEX-il9EFHQ-1; Tue, 22 Sep 2020 13:31:27 +0200
X-MC-Unique: J1BA38EwMk-HEX-il9EFHQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zaqyru0N1AmDjK1P6VefkU/C4LhhjqlGcfvGmGVfbLkyYUgvTdvSMzNPDhYlu8QLMTeekQxuQpbr74dItDS7kJVGc0MLi1eqUPoHdlO+W+v5suRj6EmDRglBuqqZ/W2D02O+AxKgqS2rIRqrAD+F1JHph9+9gv9+8tnVQHhkQIIfX1Qz+W7BRERdN2i/bw6C6xaZmKesrD/gUkZsCrYIIfCYFueh/+WFlk/6afnY6Qvno21raeIgmq34i4IgT2tG5DzPJKjW5pBv16YpDMBNrEmg44qK1hcGgxtdLAXzXLUfBfrhOW7aiLiovXuRsCyd3IY12ZLY8whRVaY0f8C9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXrBYjtogIBT2nSWrwXuZoeVPePqx7WPOJegngVIiqk=;
 b=a2g75RZ7wNzcW76gvNlQ8NaghtMtAphTNenSNyj97bRYs0TR2XOZ+Or5OwXypQ621diz6ddciawXvUkHVxB+guj07nqH3I5G3C4NPrznfjha9AkmfotM+z2s3zCA9ta3cARMZaifqP1MO1iBJVRGZf5Gxm06PlBsqkm2Llmb6T8IIIdwyL2bYh5V9ZlmneVxBffmNfhhOk0Qw/+hvxhIPZoJ35JprxHqixpem7LBcVhBFPbuveBPXtb33wfdwpTnaJzLTexwdEFgmDfMXIOucw7lEMZy86a0YGWaYwzxzPgjS1QcvDhRzKUBwAy8c8lfTj4Ofy4yh4tQX8RAwvgE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lichtvoll.de; dkim=none (message not signed)
 header.d=none;lichtvoll.de; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB6098.eurprd04.prod.outlook.com (2603:10a6:208:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Tue, 22 Sep
 2020 11:31:24 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 11:31:24 +0000
Subject: Re: [PATCH] btrfs: fix false alert caused by legacy btrfs root item
To:     kernel test robot <lkp@intel.com>, linux-btrfs@vger.kernel.org
CC:     kbuild-all@lists.01.org, Martin Steigerwald <martin@lichtvoll.de>
References: <20200922023701.32654-1-wqu@suse.com>
 <202009221943.4vKWL4lC%lkp@intel.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <c6f61285-d1ce-b3d6-6914-3f23e1a10604@suse.com>
Date:   Tue, 22 Sep 2020 19:31:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <202009221943.4vKWL4lC%lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:74::20) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:74::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4 via Frontend Transport; Tue, 22 Sep 2020 11:31:19 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ed6513e-f887-464e-467a-08d85eeb0938
X-MS-TrafficTypeDiagnostic: AM0PR04MB6098:
X-Microsoft-Antispam-PRVS: <AM0PR04MB60987152831D1E1CD2FBA3E4D63B0@AM0PR04MB6098.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qE7VgIlvjwenyPm2+IdvNXK9fjvaaIhsBE0umgUcwloq0NCOV7HZExXlemShJGXy9WtKl6xKAtgQW8c8k9EwgpDqwg79HIIaZM+2FhAfuVvj9DVcH6ANQg0YOLO1MXwZSUBnAt7IUC8ZWXshYpJR+EttwS3bpAz8qhrLNnaDgaLdjAHcZPzns3uwpUllOaRlIhN6oIIN6lBYiOM2eIAliY0SGKG+6Y+GufKOvIWD5QEgLV9aIZoyKKTud6suf5/XficT+QHeyPbckrSk7m1mEvHvewWCnnbhIwtGhkdCy1OfmcKdr2EBLhwPBWIdzR4YAgrdLelGgWxKfBNv/AuCdGaWbS3TXfhS8j2L+Ei68p+81Flvu0wwmZuevmJK9fZqCQz3AsfsFOhsTB8e4Y8TmvGdmmpUUYfFOgebpZLjoDVTVabY99pHwudT8OpTC7qjZcUF5NqUt6sMneg0gCx55dMBh6yZgSIlRlkI3Tg2XYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(396003)(136003)(16576012)(83380400001)(2616005)(956004)(4326008)(316002)(15650500001)(31686004)(2906002)(966005)(31696002)(478600001)(86362001)(66946007)(36756003)(6706004)(26005)(8936002)(6486002)(66556008)(5660300002)(66476007)(16526019)(52116002)(186003)(8676002)(6666004)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /sEBb+gUNIo6HkIpv68tC3ftc7cqrB7aDRs3Nec85XsclZ33sxrzdato/RJJEHnHOovsBflHcMcCSqNHifokxI5vsW2XWY4N+urssogxSU/FknxiPa1Zb1MDcw3U/nuw4mLyAG2mJ/mUBvFabzbtZL6xOTzFgLKv5G5L37r9uqaFpoywWAOflTOH/z5fISMRJZZIIOHYw9E00thmtI3wMTD+2cqIKovvihSni/qDBoJcDTZZntVTjYCJHunHEVZCvPNmw24rSZtN4KzjG6l3Cy0k2GBbNkd4zAsxHqzHMtminsrG5Lj72kwA5bsuYF2FAzVfCAMEJLt/8NTxOK3v4Lf73A4EhKfEuX9knGnQpWx0Qr9lC480d8PIIyDV01FlbuIRGy95UPnyJOfWkJuB24129vPKQ0JrXQxqfBrFbba+M3aATAv9975Rt2QKy4boXWjfRSf+jNGykKYFG3By8dDKLqC0VNBx5HNVA1ceBybFDfgiySDzvZ2sWjaMt8WBZY3OQEgKN7OR/ECjDS1dGOs1R/6Om+6PdCQTzosrsw7KwEB6Y1/DjSCeFCZeWKt5oUYFSKmZmVFKXHIEeiJlBo/KLPBFRkVDOaTJySgjRtB/jj2vAGh8EqGej0kq51rQ7pSnk5cpZO7pVWmjDfhv0A==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed6513e-f887-464e-467a-08d85eeb0938
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 11:31:23.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mb54N/fQyIhYiGLlHRtpnQbfBMj/YHCUfSjzh4v7owneDCYtnCtcbr9cK/M5dnQl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6098
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/22 =E4=B8=8B=E5=8D=887:12, kernel test robot wrote:
> Hi Qu,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on kdave/for-next]
> [also build test ERROR on v5.9-rc6 next-20200921]
> [cannot apply to btrfs/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-fix-fals=
e-alert-caused-by-legacy-btrfs-root-item/20200922-103827
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git f=
or-next
> config: x86_64-randconfig-s021-20200920 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.2-201-g24bdaac6-dirty
>         # save the attached .config to linux build tree
>         make W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' AR=
CH=3Dx86_64=20

Well, with my gcc-10.2.0 and C=3D1, my sparse just segfault on volumes.c...

And no such offsetof() related reports before it crashes.

I'm wondering if this sparse warning really makes any sense, especially
gcc is not complaining by itself.

Thanks,
Qu


>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from <command-line>:32:
>>> ./usr/include/linux/btrfs_tree.h:651:19: error: unknown type name 'size=
_t'
>      651 | static __inline__ size_t btrfs_legacy_root_item_size(void)
>          |                   ^~~~~~
>    ./usr/include/linux/btrfs_tree.h: In function 'btrfs_legacy_root_item_=
size':
>>> ./usr/include/linux/btrfs_tree.h:653:9: error: implicit declaration of =
function 'offsetof' [-Werror=3Dimplicit-function-declaration]
>      653 |  return offsetof(struct btrfs_root_item, generation_v2);
>          |         ^~~~~~~~
>    ./usr/include/linux/btrfs_tree.h:6:1: note: 'offsetof' is defined in h=
eader '<stddef.h>'; did you forget to '#include <stddef.h>'?
>        5 | #include <linux/btrfs.h>
>      +++ |+#include <stddef.h>
>        6 | #include <linux/types.h>
>>> ./usr/include/linux/btrfs_tree.h:653:18: error: expected expression bef=
ore 'struct'
>      653 |  return offsetof(struct btrfs_root_item, generation_v2);
>          |                  ^~~~~~
>    cc1: some warnings being treated as errors
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>=20

