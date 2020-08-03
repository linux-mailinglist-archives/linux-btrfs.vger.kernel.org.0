Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1C323A020
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 09:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgHCHOT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 03:14:19 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:20566 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbgHCHOS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 03:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1596438853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=jhTHvHNhSPFdCL7E4M+gijXetfoN2Jr5+RVv9K/4B1w=;
        b=dF1l63KY50jKdIMkcVz3VEzeJ4FeAnFyp0eQXVn6hO0QLKo6aORsrmqcK3JB57o5lEc6xA
        O12RCWZxAsxJTWFcZTML5OlEycCWKFJtD2QJAxsw3UbtuP06Wfeej8B4/md5ZwBpa1MXWp
        tS37bjG6uV8KGVN9iZIlv+mTH9Y3VMI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-5-NgPb4grqOomCmJ4C-SCM4g-1;
 Mon, 03 Aug 2020 09:14:12 +0200
X-MC-Unique: NgPb4grqOomCmJ4C-SCM4g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxySrz3963tU/7Cg1U0LqrM3PMF8O5ZmK2ZWtY7kNCjmzUln7NuNonPWZjQXAJpNL0A7NMOXAoyt5NRJL8pWVGBcGG+Vr7oXtp47cMz+rNLn5EOn01lJKO3PARrjfdW0QG/OzvJI/vUJLoi+0L0rtiT7FqGDYI3mD2qIb9GDgKGMrP0U8o6C/a9mC0YkTciQpzuyr+0BaG5GI/HG6ZHfVOB78thfG2vqgL77hSIMQMFt+zNbrXw/cnlCKkZLjLb/DXyDQMNVUvS49Fry4v9vLw7j6x4hvkus2eXp4gpEA1pwwMLk6udNK0ALDid8dLokUmKtoePTiaAB7jlhSrWGzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVfkM5Hfk5gOh2IO7AN4x6unxplaN2yIkVOVr1eTyd0=;
 b=kp35QLpixQgzkCOTZ2fMiOAWoJhCs+7YIubFbaQ0N0OkYrmdZ8cGk7kVzI9A4VN4L1eBeSqHKperMT1LYvuIe+Lx3v2+SNiaOmArC/kMpgVzRQtgjsA9+iE/oCwdLftN/VY57RNHooqcooydBDYLesrtM1AcjZA73xpBcuGjN0kL/sui654DJ84fOFrXjv0HjajJT9ROCgEl+9iTnSIc8QERi50SGX5iiS2qlDkFA8EA7+O8S6tKJRi6n1CJx9ZwPOad+8a9rElP7Rv0O9i6alFS7SBIbXydE11HHsyjgJEBObuGb7bn1hB2ZO7r9UIbixWMYwLmDaxcc3AMku46Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR0402MB3346.eurprd04.prod.outlook.com (2603:10a6:208:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Mon, 3 Aug
 2020 07:14:11 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16%3]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 07:14:11 +0000
Subject: Re: [PATCH] btrfs-progs: volumes: check stripe end against device
 boundary
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20200803070630.33234-1-wqu@suse.com>
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
Message-ID: <6b0bc908-b048-1b7c-576f-fb951ab0c7c4@suse.com>
Date:   Mon, 3 Aug 2020 15:13:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200803070630.33234-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TYAPR01CA0010.jpnprd01.prod.outlook.com (2603:1096:404::22)
 To AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TYAPR01CA0010.jpnprd01.prod.outlook.com (2603:1096:404::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Mon, 3 Aug 2020 07:14:09 +0000
X-Originating-IP: [45.77.180.217]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f1d645b-2482-4ff0-c271-08d8377cd1ef
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3346:
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3346BCC681EA4A7F44F7B44FD64D0@AM0PR0402MB3346.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fl2RmLbgwvbEWbDEfnSVwiBSKev8s4T5ZnV71mwQZEWPEt11NGETU73aPmzKNk8Ddxv4Smtz4iqd5ZDx6901wrpkzwnwVn+CSJuHC9zeB65OInzDeZPkxcMXHb1uv8obycHvdiOl46YNKsut7vvmtlwwJ9Dy/j4AtEO5yVq67xV9D27XkMShfdBPzvNIpcMjI7KcJ5mrIoRRoLSnDt+o3SHbePmO4ceV8IB5DvGMk/Cn1QP/K43oYHuuneIzIQrxDtESgzNq1+B8amqDY9shbzsLKkzeqiGsO5LvF3qy8Kf9IQQJpVD9z9yWXNe9PAxUyaaFJ4aw3yVQ3ckI9KOSl5x7j5GXcr7Rgt/kG8XvRrgDfR1VaTMjqO+07RCJJHDLoABRBOfpwXTLdY/kAlmEAy690atoWAJBmT0ipauABVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(136003)(366004)(346002)(396003)(376002)(478600001)(31686004)(16576012)(6666004)(316002)(36756003)(6916009)(6706004)(66556008)(66476007)(956004)(66946007)(186003)(55236004)(6486002)(2616005)(8936002)(52116002)(83380400001)(26005)(2906002)(5660300002)(86362001)(31696002)(8676002)(16526019)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zL+JMbIeIeb9wo0fLRfoBIyg0Vm+plNXATPuON0E31plVUlROla0MoKd9jQ9v4Qrh65pJs685SEtMF7VdSpFbovrJ5bA7J091/tPAJJVnksmMIl3w890g3w7tUM9OXv0wfj9RTjv177zaG7heWWKpf4FlqTtfsCHVkmmHHkmC5yTgpSdn4L21tTve05CdEBKKV2v2jdoHe+NKSQYZ+KoFNX4ZPD1oHxCSfyLakI4Y5j/q3tW22pkGxvIj6GC2V8hoiN8CbtYfaQW3AHeNrY64PcLdRmZxkMYPISJL18S3ihYSw+QLDASHviAWqzqa3A38BsgqB1fs5tpNGMQ8n0gTzpiStir0RlpOP+xbS4e2xCHsVIbpudAAqcKfDyXIhXObZWTwsJjVo9/vUVdsjYRSl3sEbrWVUoFk+uH+hUvGIlGduOBlSkoOqoNneeKul8vuKzk2Kex7gUdWvRrZR3njuO1RbrM/JJqQNrjAfg0ui2cAe+3ym8yhg4YmZ4ZRcnWnxyH9lNJHP6FZLhBKl5+U0ciXzhiXsrRePG4tEL3zUrrkRTxuzjQ7uuDApQ1hYz6+IuwasBeGmXB/1TlLoFu3sTia+SQnGJfOdwDCB/zgFmGpjPyzRmQyddGpLYZ5nU10q0+9eBOF/QLlXKVgrLFZA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1d645b-2482-4ff0-c271-08d8377cd1ef
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 07:14:11.1857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dv45PDHhOdrVnR1G1TRPqHGM/k/6NvCeJGM+WDgjzcJwn9YjoPHYEMK+PjBH5idH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3346
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/3 =E4=B8=8B=E5=8D=883:06, Qu Wenruo wrote:
> There is a report of kernel generationg READ bio access beyond device
> boundary.
>=20
> To make sure it's not caused by on-disk chunk items, add extra stripe
> check against device total_bytes so that btrfs check can detect such
> problem early on.

To add more info on this, kernel can already detects such problem at
mount time, by verify_one_dev_extent() on each dev extent read and
compare it against existing chunks.

Thus there is no need to enhance kernel already.

Thanks,
Qu

>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  volumes.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/volumes.c b/volumes.c
> index 538f799e7211..0467dd63d5cb 100644
> --- a/volumes.c
> +++ b/volumes.c
> @@ -1843,6 +1843,7 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *f=
s_info,
>  	u64 type;
>  	u32 chunk_ondisk_size;
>  	u32 sectorsize =3D fs_info->sectorsize;
> +	int i;
> =20
>  	/*
>  	 * Basic chunk item size check.  Note that btrfs_chunk already contains
> @@ -1953,6 +1954,34 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *=
fs_info,
>  		return -EIO;
>  	}
> =20
> +	/*
> +	 * Stripe check against device boundary
> +	 */
> +	for (i =3D 0; i < num_stripes; i++) {
> +		struct btrfs_device *dev;
> +		u64 physical;
> +		u64 devid;
> +		u64 stripe_len;
> +
> +		devid =3D btrfs_stripe_devid_nr(leaf, chunk, i);
> +		physical =3D btrfs_stripe_offset_nr(leaf, chunk, i);
> +		stripe_len =3D calc_stripe_length(type, length, num_stripes);
> +		dev =3D btrfs_find_device(fs_info, devid, NULL, NULL);
> +		/*
> +		 * Device not found? Then we may be in the bootstrap process for
> +		 * system chunks. Skip.
> +		 */
> +		if (!dev)
> +			continue;
> +		if (physical + stripe_len > dev->total_bytes) {
> +			error(
> +"chunk %llu stripe %d is beyond device boundary: devid %llu total_bytes =
%llu stripe start %llu len %llu",
> +				logical, i, devid, dev->total_bytes, physical,
> +				stripe_len);
> +			return -EUCLEAN;
> +		}
> +	}
> +
>  	return 0;
>  }
> =20
>=20

