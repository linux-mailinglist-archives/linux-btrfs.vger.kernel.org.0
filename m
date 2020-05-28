Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE781E6E58
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 00:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436864AbgE1WEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 18:04:04 -0400
Received: from syrinx.knorrie.org ([82.94.188.77]:53412 "EHLO
        syrinx.knorrie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436845AbgE1WEC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 18:04:02 -0400
Received: from [IPv6:2a02:a213:2b80:f000::12] (unknown [IPv6:2a02:a213:2b80:f000::12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id 7150C60924D05;
        Fri, 29 May 2020 00:03:58 +0200 (CEST)
Subject: Re: [PATCH 1/4] Add an ioctl to set/retrive the device properties
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20200528183451.16654-1-kreijack@libero.it>
 <20200528183451.16654-2-kreijack@libero.it>
From:   Hans van Kranenburg <hans@knorrie.org>
Autocrypt: addr=hans@knorrie.org; keydata=
 mQINBFo2pooBEADwTBe/lrCa78zuhVkmpvuN+pXPWHkYs0LuAgJrOsOKhxLkYXn6Pn7e3xm+
 ySfxwtFmqLUMPWujQYF0r5C6DteypL7XvkPP+FPVlQnDIifyEoKq8JZRPsAFt1S87QThYPC3
 mjfluLUKVBP21H3ZFUGjcf+hnJSN9d9MuSQmAvtJiLbRTo5DTZZvO/SuQlmafaEQteaOswme
 DKRcIYj7+FokaW9n90P8agvPZJn50MCKy1D2QZwvw0g2ZMR8yUdtsX6fHTe7Ym+tHIYM3Tsg
 2KKgt17NTxIqyttcAIaVRs4+dnQ23J98iFmVHyT+X2Jou+KpHuULES8562QltmkchA7YxZpT
 mLMZ6TPit+sIocvxFE5dGiT1FMpjM5mOVCNOP+KOup/N7jobCG15haKWtu9k0kPz+trT3NOn
 gZXecYzBmasSJro60O4bwBayG9ILHNn+v/ZLg/jv33X2MV7oYXf+ustwjXnYUqVmjZkdI/pt
 30lcNUxCANvTF861OgvZUR4WoMNK4krXtodBoEImjmT385LATGFt9HnXd1rQ4QzqyMPBk84j
 roX5NpOzNZrNJiUxj+aUQZcINtbpmvskGpJX0RsfhOh2fxfQ39ZP/0a2C59gBQuVCH6C5qsY
 rc1qTIpGdPYT+J1S2rY88AvPpr2JHZbiVqeB3jIlwVSmkYeB/QARAQABtCZIYW5zIHZhbiBL
 cmFuZW5idXJnIDxoYW5zQGtub3JyaWUub3JnPokCTgQTAQoAOBYhBOJv1o/B6NS2GUVGTueB
 VzIYDCpVBQJaNq7KAhsDBQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEOeBVzIYDCpVgDMQ
 ANSQMebh0Rr6RNhfA+g9CKiCDMGWZvHvvq3BNo9TqAo9BC4neAoVciSmeZXIlN8xVALf6rF8
 lKy8L1omocMcWw7TlvZHBr2gZHKlFYYC34R2NvxS0xO8Iw5rhEU6paYaKzlrvxuXuHMVXgjj
 bM3zBiN8W4b9VW1MoynP9nvm1WaGtFI9GIyK9j6mBCU+N5hpvFtt4DBmuWjzdDkd3sWUufYd
 nQhGimWHEg95GWhQUiFvr4HRvYJpbjRRRQG3O/5Fm0YyTYZkI5CDzQIm5lhqKNqmuf2ENstS
 8KcBImlbwlzEpK9Pa3Z5MUeLZ5Ywwv+d11fyhk53aT9bipdEipvcGa6DrA0DquO4WlQR+RKU
 ywoGTgntwFu8G0+tmD8J1UE6kIzFwE5kiFWjM0rxv1tAgV9ZWqmp3sbI7vzbZXn+KI/wosHV
 iDeW5rYg+PdmnOlYXQIJO+t0KmF5zJlSe7daylKZKTYtk7w1Fq/Oh1Rps9h1C4sXN8OAUO7h
 1SAnEtehHfv52nPxwZiI6eqbvqV0uEEyLFS5pCuuwmPpC8AmOrciY2T8T+4pmkJNO2Nd3jOP
 cnJgAQrxPvD7ACp/85LParnoz5c9/nPHJB1FgbAa7N5d8ubqJgi+k9Q2lAL9vBxK67aZlFZ0
 Kd7u1w1rUlY12KlFWzxpd4TuHZJ8rwi7PUceuQINBFo2sK8BEADSZP5cKnGl2d7CHXdpAzVF
 6K4Hxwn5eHyKC1D/YvsY+otq3PnfLJeMf1hzv2OSrGaEAkGJh/9yXPOkQ+J1OxJJs9CY0fqB
 MvHZ98iTyeFAq+4CwKcnZxLiBchQJQd0dFPujtcoMkWgzp3QdzONdkK4P7+9XfryPECyCSUF
 ib2aEkuU3Ic4LYfsBqGR5hezbJqOs96ExMnYUCEAS5aeejr3xNb8NqZLPqU38SQCTLrAmPAX
 glKVnYyEVxFUV8EXXY6AK31lRzpCqmPxLoyhPAPda9BXchRluy+QOyg+Yn4Q2DSwbgCYPrxo
 HTZKxH+E+JxCMfSW35ZE5ufvAbY3IrfHIhbNnHyxbTRgYMDbTQCDyN9F2Rvx3EButRMApj+v
 OuaMBJF/fWfxL3pSIosG9Q7uPc+qJvVMHMRNnS0Y1QQ5ZPLG0zI5TeHzMnGmSTbcvn/NOxDe
 6EhumcclFS0foHR78l1uOhUItya/48WCJE3FvOS3+KBhYvXCsG84KVsJeen+ieX/8lnSn0d2
 ZvUsj+6wo+d8tcOAP+KGwJ+ElOilqW29QfV4qvqmxnWjDYQWzxU9WGagU3z0diN97zMEO4D8
 SfUu72S5O0o9ATgid9lEzMKdagXP94x5CRvBydWu1E5CTgKZ3YZv+U3QclOG5p9/4+QNbhqH
 W4SaIIg90CFMiwARAQABiQRsBBgBCgAgFiEE4m/Wj8Ho1LYZRUZO54FXMhgMKlUFAlo2sK8C
 GwICQAkQ54FXMhgMKlXBdCAEGQEKAB0WIQRJbJ13A1ob3rfuShiywd9yY2FfbAUCWjawrwAK
 CRCywd9yY2FfbMKbEACIGLdFrD5j8rz/1fm8xWTJlOb3+o5A6fdJ2eyPwr5njJZSG9i5R28c
 dMmcwLtVisfedBUYLaMBmCEHnj7ylOgJi60HE74ZySX055hKECNfmA9Q7eidxta5WeXeTPSb
 PwTQkAgUZ576AO129MKKP4jkEiNENePMuYugCuW7XGR+FCEC2efYlVwDQy24ZfR9Q1dNK2ny
 0gH1c+313l0JcNTKjQ0e7M9KsQSKUr6Tk0VGTFZE2dp+dJF1sxtWhJ6Ci7N1yyj3buFFpD9c
 kj5YQFqBkEwt3OGtYNuLfdwR4d47CEGdQSm52n91n/AKdhRDG5xvvADG0qLGBXdWvbdQFllm
 v47TlJRDc9LmwpIqgtaUGTVjtkhw0SdiwJX+BjhtWTtrQPbseDe2pN3gWte/dPidJWnj8zzS
 ggZ5otY2reSvM+79w/odUlmtaFx+IyFITuFnBVcMF0uGmQBBxssew8rePQejYQHz0bZUDNbD
 VaZiXqP4njzBJu5+nzNxQKzQJ0VDF6ve5K49y0RpT4IjNOupZ+OtlZTQyM7moag+Y6bcJ7KK
 8+MRdRjGFFWP6H/RCSFAfoOGIKTlZHubjgetyQhMwKJQ5KnGDm+XUkeIWyevPfCVPNvqF2q3
 viQm0taFit8L+x7ATpolZuSCat5PSXtgx1liGjBpPKnERxyNLQ/erRNcEACwEJliFbQm+c2i
 6ccpx2cdtyAI1yzWuE0nr9DqpsEbIZzTCIVyry/VZgdJ27YijGJWesj/ie/8PtpDu0Cf1pty
 QOKSpC9WvRCFGJPGS8MmvzepmX2DYQ5MSKTO5tRJZ8EwCFfd9OxX2g280rdcDyCFkY3BYrf9
 ic2PTKQokx+9sLCHAC/+feSx/MA/vYpY1EJwkAr37mP7Q8KA9PCRShJziiljh5tKQeIG4sz1
 QjOrS8WryEwI160jKBBNc/M5n2kiIPCrapBGsL58MumrtbL53VimFOAJaPaRWNSdWCJSnVSv
 kCHMl/1fRgzXEMpEmOlBEY0Kdd1Ut3S2cuwejzI+WbrQLgeps2N70Ztq50PkfWkj0jeethhI
 FqIJzNlUqVkHl1zCWSFsghxiMyZmqULaGcSDItYQ+3c9fxIO/v0zDg7bLeG9Zbj4y8E47xqJ
 6brtAAEJ1RIM42gzF5GW71BqZrbFFoI0C6AzgHjaQP1xfj7nBRSBz4ObqnsuvRr7H6Jme5rl
 eg7COIbm8R7zsFjF4tC6k5HMc1tZ8xX+WoDsurqeQuBOg7rggmhJEpDK2f+g8DsvKtP14Vs0
 Sn7fVJi87b5HZojry1lZB2pXUH90+GWPF7DabimBki4QLzmyJ/ENH8GspFulVR3U7r3YYQ5K
 ctOSoRq9pGmMi231Q+xx9LkCDQRaOtArARAA50ylThKbq0ACHyomxjQ6nFNxa9ICp6byU9Lh
 hKOax0GB6l4WebMsQLhVGRQ8H7DT84E7QLRYsidEbneB1ciToZkL5YFFaVxY0Hj1wKxCFcVo
 CRNtOfoPnHQ5m/eDLaO4o0KKL/kaxZwTn2jnl6BQDGX1Aak0u4KiUlFtoWn/E/NIv5QbTGSw
 IYuzWqqYBIzFtDbiQRvGw0NuKxAGMhwXy8VP05mmNwRdyh/CC4rWQPBTvTeMwr3nl8/G+16/
 cn4RNGhDiGTTXcX03qzZ5jZ5N7GLY5JtE6pTpLG+EXn5pAnQ7MvuO19cCbp6Dj8fXRmI0SVX
 WKSo0A2C8xH6KLCRfUMzD7nvDRU+bAHQmbi5cZBODBZ5yp5CfIL1KUCSoiGOMpMin3FrarIl
 cxhNtoE+ya23A+JVtOwtM53ESra9cJL4WPkyk/E3OvNDmh8U6iZXn4ZaKQTHaxN9yvmAUhZQ
 iQi/sABwxCcQQ2ydRb86Vjcbx+FUr5OoEyQS46gc3KN5yax9D3H9wrptOzkNNMUhFj0oK0fX
 /MYDWOFeuNBTYk1uFRJDmHAOp01rrMHRogQAkMBuJDMrMHfolivZw8RKfdPzgiI500okLTzH
 C0wgSSAOyHKGZjYjbEwmxsl3sLJck9IPOKvqQi1DkvpOPFSUeX3LPBIav5UUlXt0wjbzInUA
 EQEAAYkCNgQYAQoAIBYhBOJv1o/B6NS2GUVGTueBVzIYDCpVBQJaOtArAhsMAAoJEOeBVzIY
 DCpV4kgP+wUh3BDRhuKaZyianKroStgr+LM8FIUwQs3Fc8qKrcDaa35vdT9cocDZjkaGHprp
 mlN0OuT2PB+Djt7am2noV6Kv1C8EnCPpyDBCwa7DntGdGcGMjH9w6aR4/ruNRUGS1aSMw8sR
 QgpTVWEyzHlnIH92D+k+IhdNG+eJ6o1fc7MeC0gUwMt27Im+TxVxc0JRfniNk8PUAg4kvJq7
 z7NLBUcJsIh3hM0WHQH9AYe/mZhQq5oyZTsz4jo/dWFRSlpY7zrDS2TZNYt4cCfZj1bIdpbf
 SpRi9M3W/yBF2WOkwYgbkqGnTUvr+3r0LMCH2H7nzENrYxNY2kFmDX9bBvOWsWpcMdOEo99/
 Iayz5/q2d1rVjYVFRm5U9hG+C7BYvtUOnUvSEBeE4tnJBMakbJPYxWe61yANDQubPsINB10i
 ngzsm553yqEjLTuWOjzdHLpE4lzD416ExCoZy7RLEHNhM1YQSI2RNs8umlDfZM9Lek1+1kgB
 vT3RH0/CpPJgveWV5xDOKuhD8j5l7FME+t2RWP+gyLid6dE0C7J03ir90PlTEkMEHEzyJMPt
 OhO05Phy+d51WPTo1VSKxhL4bsWddHLfQoXW8RQ388Q69JG4m+JhNH/XvWe3aQFpYP+GZuzO
 hkMez0lHCaVOOLBSKHkAHh9i0/pH+/3hfEa4NsoHCpyy
Message-ID: <50158c8d-ee70-9692-ab4b-5ce1b159d158@knorrie.org>
Date:   Fri, 29 May 2020 00:03:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200528183451.16654-2-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On 5/28/20 8:34 PM, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> 
> ---
>  fs/btrfs/ioctl.c           | 67 ++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.c         |  2 +-
>  fs/btrfs/volumes.h         |  2 ++
>  include/uapi/linux/btrfs.h | 40 +++++++++++++++++++++++
>  4 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 40b729dce91c..cba3fa942e2f 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4724,6 +4724,71 @@ static int btrfs_ioctl_set_features(struct file *file, void __user *arg)
>  	return ret;
>  }
>  
> +static long btrfs_ioctl_dev_properties(struct file *file,
> +						void __user *argp)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	struct btrfs_ioctl_dev_properties dev_props;
> +	struct btrfs_device	*device;
> +        struct btrfs_root *root = fs_info->chunk_root;
> +        struct btrfs_trans_handle *trans;

FYI, the code contains a big mix of spaces and tabs to indent lines.

> +	int ret;
> +	u64 prev_type;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (copy_from_user(&dev_props, argp, sizeof(dev_props)))
> +		return -EFAULT;
> +
> +	device = btrfs_find_device(fs_info->fs_devices, dev_props.devid,
> +				NULL, NULL, false);
> +	if (!device) {
> +		btrfs_info(fs_info, "change_dev_properties: unable to find device %llu",
> +			   dev_props.devid);
> +		return -ENODEV;
> +	}
> +
> +	if (dev_props.properties & BTRFS_DEV_PROPERTY_READ) {
> +		u64 props = dev_props.properties;
> +		memset(&dev_props, 0, sizeof(dev_props));
> +		if (props & BTRFS_DEV_PROPERTY_TYPE) {
> +			dev_props.properties = BTRFS_DEV_PROPERTY_TYPE;
> +			dev_props.type = device->type;
> +		}
> +		if(copy_to_user(argp, &dev_props, sizeof(dev_props)))
> +			return -EFAULT;
> +		return 0;
> +	}
> +
> +	/* it is possible to set only BTRFS_DEV_PROPERTY_TYPE for now */
> +	if (dev_props.properties & ~(BTRFS_DEV_PROPERTY_TYPE))
> +		return -EPERM;
> +
> +	trans = btrfs_start_transaction(root, 0);
> +        if (IS_ERR(trans))
> +                return PTR_ERR(trans);
> +
> +	prev_type = device->type;
> +	device->type = dev_props.type;
> +	ret = btrfs_update_device(trans, device);
> +
> +        if (ret < 0) {
> +                btrfs_abort_transaction(trans, ret);
> +                btrfs_end_transaction(trans);
> +		device->type = prev_type;
> +		return  ret;
> +        }
> +
> +        ret = btrfs_commit_transaction(trans);
> +	if (ret < 0)
> +		device->type = prev_type;
> +
> +	return ret;
> +
> +}
> +
>  static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
>  {
>  	struct btrfs_ioctl_send_args *arg;
> @@ -4907,6 +4972,8 @@ long btrfs_ioctl(struct file *file, unsigned int
>  		return btrfs_ioctl_get_subvol_rootref(file, argp);
>  	case BTRFS_IOC_INO_LOOKUP_USER:
>  		return btrfs_ioctl_ino_lookup_user(file, argp);
> +	case BTRFS_IOC_DEV_PROPERTIES:
> +		return btrfs_ioctl_dev_properties(file, argp);
>  	}
>  
>  	return -ENOTTY;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index be1e047a489e..5265f54c2931 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2710,7 +2710,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	return ret;
>  }
>  
> -static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
> +int btrfs_update_device(struct btrfs_trans_handle *trans,
>  					struct btrfs_device *device)
>  {
>  	int ret;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index f067b5934c46..0ac5bf2b95e6 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -577,5 +577,7 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
>  int btrfs_bg_type_to_factor(u64 flags);
>  const char *btrfs_bg_type_to_raid_name(u64 flags);
>  int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
> +int btrfs_update_device(struct btrfs_trans_handle *trans,
> +                                        struct btrfs_device *device);
>  
>  #endif
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index e6b6cb0f8bc6..bb096075677d 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -842,6 +842,44 @@ struct btrfs_ioctl_get_subvol_rootref_args {
>  		__u8 align[7];
>  };
>  
> +#define BTRFS_DEV_PROPERTY_TYPE		(1ULL << 0)
> +#define BTRFS_DEV_PROPERTY_DEV_GROUP	(1ULL << 1)
> +#define BTRFS_DEV_PROPERTY_SEEK_SPEED	(1ULL << 2)
> +#define BTRFS_DEV_PROPERTY_BANDWIDTH	(1ULL << 3)
> +#define BTRFS_DEV_PROPERTY_READ		(1ULL << 60)
> +
> +/*
> + * The ioctl BTRFS_IOC_DEV_PROPERTIES can read and write the device properties.
> + *
> + * The properties that the user want to write have to be set
> + * in the 'properties' field using the BTRFS_DEV_PROPERTY_xxxx constants.
> + *
> + * If the ioctl is used to read the device properties, the bit
> + * BTRFS_DEV_PROPERTY_READ has to be set in the 'properties' field.
> + * In this case the properties that the user want have to be set in the
> + * 'properties' field. The kernel doesn't return a property that was not
> + * required, however it may return a subset of the requested properties.
> + * The returned properties have the corrispondent BTRFS_DEV_PROPERTY_xxxx
> + * flag set in the 'properties' field.
> + *
> + * Up to 2020/05/11 the only properties that can be read/write is the 'type'
> + * one.
> + */
> +struct btrfs_ioctl_dev_properties {
> +	__u64	devid;
> +	__u64	properties;
> +	__u64	type;
> +	__u32	dev_group;
> +	__u8	seek_speed;
> +	__u8	bandwidth;
> +
> +	/*
> +	 * for future expansion
> +	 */
> +	__u8	unused1[2];
> +	__u64	unused2[4];
> +};
> +
>  /* Error codes as returned by the kernel */
>  enum btrfs_err_code {
>  	BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET = 1,
> @@ -970,5 +1008,7 @@ enum btrfs_err_code {
>  				struct btrfs_ioctl_ino_lookup_user_args)
>  #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
>  				struct btrfs_ioctl_vol_args_v2)
> +#define BTRFS_IOC_DEV_PROPERTIES _IOW(BTRFS_IOCTL_MAGIC, 64, \
> +				struct btrfs_ioctl_dev_properties)
>  
>  #endif /* _UAPI_LINUX_BTRFS_H */
> 

